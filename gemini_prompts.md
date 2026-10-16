# Gemini AI Prompts & Engineering Documentation

This document contains all prompt texts, system instructions, tone adaptation directives, and parameter configurations used in the **AI Resume Builder Automation**.

---

## 1. Model Configuration & Parameters

| Parameter | Recommended Setting | Rationale |
| :--- | :--- | :--- |
| **Model** | `gemini-1.5-flash` (or `gemini-2.0-flash`) | Ultra-fast latency, cost-effective, excellent structured JSON generation. |
| **Temperature** | `0.3` | Low temperature ensures factual adherence, structural consistency, and reliable JSON formatting while retaining creative professional phrasing. |
| **Top-P** | `0.85` | Ensures focused vocabulary suitable for high-caliber resumes. |
| **Top-K** | `40` | Prevents erratic keyword hallucination. |
| **Response MIME Type** | `application/json` | Guarantees strict JSON output conforming to the required schema without markdown backticks. |

---

## 2. Complete Gemini Master Prompt Template

```text
You are an elite Executive Career Strategist, Technical Recruiter, and Resume Engineering Specialist.
Your task is to analyze candidate information and generate a high-impact, professional resume structured strictly according to the candidate's selected resume style.

==================================================
CANDIDATE INFORMATION
==================================================
- Full Name: {{ $json.sanitizedData.name }}
- Email: {{ $json.sanitizedData.email }}
- Phone: {{ $json.sanitizedData.phone }}
- Location / City: {{ $json.sanitizedData.city }}
- Total Experience: {{ $json.sanitizedData.experienceYears }} Years
- Selected Resume Type: {{ $json.sanitizedData.resumeType }}
- Raw Career Objective: {{ $json.sanitizedData.careerObjective }}
- Raw Skills: {{ $json.sanitizedData.skills }}
- Raw Work Experience: {{ $json.sanitizedData.workExperience }}
- Raw Education: {{ $json.sanitizedData.education }}

==================================================
TONE & STYLE DIRECTIVE FOR: {{ $json.sanitizedData.resumeType }}
==================================================
{{ $json.theme.toneInstruction }}

==================================================
SECTION GENERATION RULES
==================================================
1. PERSONAL DETAILS:
   - Include Candidate Name, Email, Phone, City, and infer an executive-level Professional Title matching their experience level.

2. PROFESSIONAL SUMMARY:
   - Transform the raw Career Objective into a powerful 3-4 sentence summary.
   - For Professional: Use active corporate terminology, leadership focus, and ROI alignment.
   - For Creative: Use an engaging first/third-person narrative emphasizing brand vision, user experience, and originality.
   - For Tech: Focus on systems engineering, latency/throughput metrics, cloud stack, and technical problem-solving.

3. SKILLS SECTION:
   - Categorize the raw comma-separated skills into 2 to 3 logical domains (e.g., "Languages & Frameworks", "Cloud & DevOps", "Design & Prototyping", "Management & Strategy").
   - Standardize terminology (e.g., capitalize correctly, add industry-standard tool names).

4. WORK EXPERIENCE:
   - Parse each job entry into Role, Company, Period, and 2-4 quantified achievement bullets.
   - Every bullet MUST begin with an action verb (e.g., "Architected", "Accelerated", "Pioneered", "Optimized", "Delivered").
   - Quantify results with metrics (e.g., percentages, dollar amounts, time saved) wherever contextually plausible.

5. EDUCATION & CREDENTIALS:
   - Extract Degree, Institution, graduation timeframe, and relevant certifications.

6. ACHIEVEMENTS SECTION:
   - Formulate 2-3 standout career highlights or milestone awards reflecting top performance.

7. RELEVANT PROJECTS SECTION:
   - Provide 2 production-grade projects demonstrating mastery of the skills mentioned.

==================================================
STRICT JSON OUTPUT REQUIREMENT
==================================================
Return ONLY valid JSON matching this exact schema. Do NOT include markdown blocks, explanation text, or triple backticks.

{
  "personalDetails": {
    "name": "string",
    "title": "string",
    "email": "string",
    "phone": "string",
    "city": "string",
    "experienceYears": number
  },
  "professionalSummary": "string",
  "skills": [
    {
      "category": "string",
      "items": ["string", "string"]
    }
  ],
  "experience": [
    {
      "role": "string",
      "company": "string",
      "period": "string",
      "highlights": ["string", "string"]
    }
  ],
  "education": [
    {
      "degree": "string",
      "institution": "string",
      "period": "string"
    }
  ],
  "achievements": [
    "string",
    "string"
  ],
  "projects": [
    {
      "name": "string",
      "techStack": "string",
      "description": "string"
    }
  ]
}
```

---

## 3. Dynamic Tone & Style Directives (Dropdown Switcher)

Depending on the dropdown chosen by the candidate in the HTML form, n8n dynamically passes one of the following directives into the Gemini prompt:

### A. Professional Resume Directive
```text
Formal corporate business tone. Focus heavily on quantified achievements, business ROI, strategic leadership, cross-functional project management, and governance. Use executive language such as 'orchestrated', 'streamlined', 'delivered $X in value', and 'fostered stakeholder alignment'.
```

### B. Creative Resume Directive
```text
Friendly, inspiring, and narrative tone. Emphasize storytelling, creative vision, brand personality, human-centric design, original concepts, and cultural resonance. Focus on craft, emotional engagement, and creative problem-solving.
```

### C. Tech Resume Directive
```text
Technical, concise, and engineering-driven tone. Highlight programming languages, system architectures, cloud infrastructure (AWS/GCP/Azure), CI/CD pipelines, containerization, microservices, database schemas, hard skills, and performance benchmarks (e.g., latency reduction, throughput, high availability).
```

---

## 4. Sample Gemini Output (JSON)

Below is an authentic sample of Gemini's response when processing candidate data:

```json
{
  "personalDetails": {
    "name": "Mehrab Khan",
    "title": "Lead Cloud Automation & Platform Engineer",
    "email": "mehrab.khan.dev@gmail.com",
    "phone": "+91 98765 43210",
    "city": "Bengaluru, Karnataka, India",
    "experienceYears": 6
  },
  "professionalSummary": "Lead Cloud Automation and Platform Engineer with over 6 years of expertise architecting high-throughput distributed architectures, autonomous event-driven microservices, and enterprise LLM integrations. Proven record modernizing infrastructure pipelines at Razorpay and Swiggy, achieving 99.99% uptime while cutting recurring manual operational workloads by 65%.",
  "skills": [
    {
      "category": "Languages & Runtimes",
      "items": ["TypeScript", "Node.js", "Python 3.11", "SQL", "Go"]
    },
    {
      "category": "Automation & Cloud Infrastructure",
      "items": ["n8n Workflow Engine", "Docker", "Kubernetes (CKA)", "Google Gemini API", "PostgreSQL", "Redis", "Kafka", "GitHub Actions CI/CD"]
    }
  ],
  "experience": [
    {
      "role": "Senior Automation & Backend Engineer",
      "company": "Razorpay Software",
      "period": "2022 - Present",
      "highlights": [
        "Architected 45+ enterprise n8n and Python workflows connecting merchant payment webhooks, reducing manual reconciliations by 65%.",
        "Engineered production Google Gemini AI ingestion pipelines handling 50,000+ daily documents with sub-second response times.",
        "Containerized mission-critical backend services with Docker and Kubernetes, achieving zero-downtime rolling deployments during festive flash sales."
      ]
    },
    {
      "role": "Software Development Engineer (SDE-2)",
      "company": "Swiggy",
      "period": "2019 - 2022",
      "highlights": [
        "Designed and maintained resilient delivery dispatch endpoints serving 2.5M+ daily active requests across 500+ Indian cities.",
        "Mentored a team of 5 junior software engineers and elevated unit test coverage from 64% to 92%."
      ]
    }
  ],
  "education": [
    {
      "degree": "B.Tech in Computer Science & Engineering",
      "institution": "National Institute of Technology (NIT) Trichy",
      "period": "2015 - 2019"
    }
  ],
  "achievements": [
    "Recipient of the 2023 Razorpay Tech Excellence Award for pioneer LLM workflow orchestration.",
    "Engineered internal automation framework saving an estimated 1,200 engineering hours annually."
  ],
  "projects": [
    {
      "name": "Merchant KYC & Compliance Triage Gateway",
      "techStack": "n8n, Python, Google Gemini, Slack Webhooks",
      "description": "Autonomous alert listener that correlates distributed logs, identifies root causes via LLM, and triggers remediation steps."
    },
    {
      "name": "High-Throughput Payment Webhook Ingestion Engine",
      "techStack": "Node.js, Redis, Docker, AWS",
      "description": "Rate-limiting proxy processing up to 12,000 incoming webhooks per second with zero message loss."
    }
  ]
}
```
