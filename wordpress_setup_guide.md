# WordPress Private Page Publishing & Integration Guide

This guide walks you step-by-step through configuring WordPress, connecting it to n8n, publishing candidate resumes as **Private Pages**, and capturing the generated page URLs for the email automation.

---

## 1. WordPress Authentication Setup (Application Passwords)

Since WordPress 5.6+, the native and most secure method to authenticate with the **WordPress REST API** from external tools like n8n is via **Application Passwords**.

### Step-by-Step Configuration:
1. Log in to your WordPress Dashboard as an **Administrator**.
2. Go to **Users &rarr; Profile** (or **Users &rarr; All Users** and edit your admin user).
3. Scroll down to the **Application Passwords** section.
4. In the *New Application Password Name* field, enter: `n8n AI Resume Automation`.
5. Click **Add New Application Password**.
6. WordPress will display a generated 24-character password (e.g., `abcd efgh ijkl mnop qrst uvwx`).
   > **Note:** Copy this password immediately. You will use it in n8n.

---

## 2. Configuring n8n to Connect to WordPress

You can connect n8n to WordPress using either **Method A (WordPress REST API via HTTP Request)** or **Method B (Native WordPress Node)**. Both methods are supported by our workflow.

### Method A: HTTP Request Node (Recommended & Universal)
This method is already pre-configured inside `n8n_workflow_ai_resume_builder.json`:
- **Method:** `POST`
- **URL:** `https://your-wordpress-domain.com/wp-json/wp/v2/pages`
- **Authentication:** `Generic Credential Type` &rarr; `HTTP Basic Auth`
  - **User:** Your WordPress Admin Username (e.g., `admin`)
  - **Password:** The 24-character Application Password generated in Step 1.
- **Headers:**
  - `Content-Type`: `application/json`
- **JSON Body:**
  ```json
  {
    "title": "={{ $json.pageTitle }}",
    "content": "={{ $json.htmlResume }}",
    "status": "private"
  }
  ```

### Method B: Native WordPress Node
If you prefer using the native n8n community node:
1. Add the **WordPress** node to your canvas.
2. In Credentials, select **WordPress API** and enter:
   - URL: `https://your-wordpress-domain.com`
   - Username: Your admin username
   - Password: Your Application Password
3. Set **Resource** to `Post` or `Page`.
4. Set **Operation** to `Create`.
5. Set **Title** to `=Resume for {{ $('Validate Input Data').item.json.sanitizedData.name }}`.
6. Set **Content** to `={{ $json.htmlResume }}`.
7. Under Additional Fields &rarr; **Status**, select **`private`**.

---

## 3. Why Publish as a "Private Page"?

The task specification explicitly requires:
> *"Publish the resume HTML as a private page. Page title must be: Resume for NAME. Store the page URL output for emailing."*

### Key Benefits of `status: "private"`:
1. **Confidentiality**: The page is not listed in public menus, search feeds, or search engines (Google/Bing).
2. **Access Control**: Only logged-in users with appropriate privileges (or viewers with authorization) can view the page.
3. **Clean URLs**: WordPress generates a permanent slug (e.g., `https://yourdomain.com/resume-for-kaif-ansari/`) that can be emailed directly to the candidate.

---

## 4. Capturing the Generated Page URL

When WordPress successfully creates a page via the REST API, it returns an HTTP 201 Created response containing the page metadata.

The relevant fields returned are:
- `id`: The unique WordPress post ID (e.g., `1245`).
- `link`: The permanent URL of the page (e.g., `https://yourdomain.com/resume-for-mehrab-khan/`).
- `status`: Confirmed as `"private"`.
- `title.rendered`: `"Resume for Mehrab Khan"`.

In our workflow, the downstream **Format HTML Email** Code node extracts this link with:
```javascript
const wpData = $input.first().json;
const wpUrl = wpData.link || wpData.guid?.rendered || `https://your-wordpress-site.com/resume-for-${encodeURIComponent(candidate.name.toLowerCase().replace(/\s+/g, '-'))}/`;
```
This link is then embedded directly into the CTA button inside the email sent to the user.

---

## 5. Sample Output & Link for Project Submission

For your project submission report, here is an example of the created WordPress link format:

```text
WordPress Resume Link Format:
https://your-wordpress-site.com/resume-for-mehrab-khan/

Sample Status in WordPress Admin:
- Page Title: Resume for Mehrab Khan
- Page Status: Private
- Template: Full Width / Standalone HTML
- Visibility: Private (Editor / Admin Only)
```

*(If testing locally without a live domain, you can use LocalWP, WordPress Playground, or a ngrok tunnel to test live REST API creation).*
