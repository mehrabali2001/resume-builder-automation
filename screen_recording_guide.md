# Screen Recording Presentation Guide & Script

This guide provides a complete, structured video presentation script, recording checklist, and walkthrough plan for recording your screen demo of the **AI Resume Builder Automation**.

---

## 1. Quick Recording Overview

- **Target Video Duration:** 4 to 6 minutes
- **Recommended Tools:** OBS Studio, Loom, Camtasia, or Windows Snipping Tool / Xbox Game Bar (`Win + G`)
- **Key Tabs to Have Open Before Starting:**
  1. **Tab 1:** `index.html` (The Custom HTML Form open in your browser).
  2. **Tab 2:** n8n Canvas (Showing the active workflow with all nodes visible).
  3. **Tab 3:** WordPress Admin & Pages list (Showing the Private Resume Page created).
  4. **Tab 4:** Email Inbox / Webmail (Showing the received HTML email).
  5. **Tab 5:** One of the generated sample resumes (`samples/tech_resume_sample.html`).

---

## 2. Step-by-Step Screen Recording Script

### Scene 1: Introduction & Architecture Overview (0:00 - 0:45)
- **Visual:** Show n8n canvas zoomed out so all connected nodes are visible.
- **Spoken Script:**
  > *"Hello everyone! Today, I am excited to demonstrate my end-to-end AI Resume Builder automation system built using n8n, Google Gemini AI, WordPress REST API, and automated HTML email delivery.*
  >
  > *The goal of this system is to capture raw user career details from a custom responsive web form, validate the data strictly with JavaScript, pass it to Google Gemini to synthesize a structured resume with tone adaptation, compile it into an elegant HTML resume based on dynamic styling rules, publish it securely as a Private Page on WordPress, and automatically dispatch a mobile-friendly HTML email containing their private resume link."*

---

### Scene 2: The Custom HTML Form & Validation (0:45 - 1:30)
- **Visual:** Switch to browser showing `index.html`.
- **Spoken Script:**
  > *"Let's start with Step 1: the custom HTML form. As you can see, we have fields for Name, Email, Phone, City, Years of Experience, Skills, Education, Work Experience, and Career Objective.*
  >
  > *We also have a dynamic Resume Type selector with three styles: Professional, Creative, and Tech. Notice that when I change the dropdown, the theme preview card dynamically updates the color swatches and design description.*
  >
  > *First, let's test our error handling. If I click Submit without filling required fields or enter an invalid email, the JavaScript validation immediately catches it, and our n8n validation node returns a clear, structured JSON error response.*
  >
  > *Now, let's click 'Mehrab Khan (Tech)' to prefill a realistic candidate profile—Mehrab Khan, a Lead Cloud Automation Engineer from Bengaluru, selecting the Tech Resume template."*

---

### Scene 3: n8n Workflow Deep Dive (1:30 - 3:00)
- **Visual:** Switch to n8n canvas and zoom in on specific nodes as you explain them.
- **Spoken Script:**
  > *"Let's inspect how n8n processes this submission step-by-step:*
  >
  > *1. **Webhook Trigger Node**: Receives the POST payload from our form in real-time.*
  >
  > *2. **JavaScript Validation Node**: Validates the input using strict regex and type checks. If any field fails, our 'Is Input Valid?' router diverts to a 400 Bad Request response node, protecting our Gemini API quota.*
  >
  > *3. **Select Template & Prepare Prompt Node**: This Code node implements our theme switch logic. For our Tech Resume, it selects high-resolution tech banner imagery, a dark cyber neon-green palette, and injects a specialized engineering tone directive into our Gemini prompt.*
  >
  > *4. **Gemini AI Generator Node**: Calls Google Gemini using structured JSON mode. Gemini expands the raw objective into an executive summary, groups skills logically, structures the work experience with quantified bullet points, and generates achievements and relevant projects.*
  >
  > *5. **Format Resume to HTML Node**: This modular JavaScript node converts the JSON response into semantic, responsive HTML with badges, timeline cards, custom Google Fonts, and a print stylesheet for instant PDF export.*
  >
  > *6. **Publish to WordPress Node**: Connects via Application Passwords to the WordPress REST API to publish the resume as a Private Page titled 'Resume for Mehrab Khan'. This ensures candidate data remains strictly confidential.*
  >
  > *7. **Format HTML Email & Send Node**: Finally, the system builds an email with matching banner aesthetics, a personalized greeting, and a high-contrast CTA button linking directly to the private WordPress page, before sending it out."*

---

### Scene 4: Live Execution & Demonstration (3:00 - 4:15)
- **Visual:** Go back to `index.html` and click **"Generate Resume with AI & Publish"**. Show loading state, then switch to n8n to show the workflow execution light up green.
- **Spoken Script:**
  > *"Now, let's hit 'Generate Resume with AI & Publish' and watch the execution live!*
  >
  > *The webhook receives the payload... the validation passes... Gemini synthesizes the structured resume... our HTML engine compiles the layout... WordPress creates the private page... and the email is dispatched!*
  >
  > *And right here on our web form, we receive our success response containing the direct WordPress link."*

---

### Scene 5: Verifying the Results (WordPress & Email) (4:15 - 5:15)
- **Visual:** 
  1. Open the created WordPress page (or `samples/tech_resume_sample.html`).
  2. Open the email inbox showing the received email.
- **Spoken Script:**
  > *"Let's examine the generated output:*
  >
  > *Here is the generated WordPress page. Look at the visual excellence: high-res tech banner, terminal-styled contact bar, neon green accents, categorized skills badges, quantified experience bullets, and projects grid. When we press Ctrl + P, it automatically formats into a print-ready PDF with zero web clutter!*
  >
  > *And here is the confirmation email received in the inbox. It features matching banner branding, a personalized greeting, a short thank-you note, and the 'View Your Private Resume Page' button that takes the user right to their document."*

---

### Scene 6: Conclusion (5:15 - 5:30)
- **Visual:** Return to n8n canvas.
- **Spoken Script:**
  > *"To summarize: this project demonstrates reliable webhook handling, rigorous JavaScript validation, intelligent prompt engineering with Gemini, automated CMS publishing via WordPress REST API, and responsive email delivery. All workflow files, prompts, and code documentation are fully documented and ready for deployment. Thank you for watching!"*

---

## 3. Pre-Recording Checklist

- [ ] n8n is running and workflow is active (or set to "Listen for Test Event").
- [ ] Gemini API key is configured in n8n.
- [ ] WordPress URL and Application Password are set up.
- [ ] Test the form once before recording to verify end-to-end execution.
- [ ] Check microphone volume and set screen resolution to 1080p (1920x1080).
- [ ] Keep browser bookmarks bar hidden (`Ctrl + Shift + B`) for a clean presentation look.
