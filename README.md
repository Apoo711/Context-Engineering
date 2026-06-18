# 🚀 Context Engineering Suite (Antigravity CLI Edition)

A spec-driven development toolkit to eliminate AI code bloat and automate software lifecycle tasks.

---

💡 **Foundational Philosophy:** Read about our philosophy in the blog post: [**Beyond the Prompt: A Practical Guide to Context Engineering with Gemini**](https://aryan-gupta.is-a.dev/blog/2026-06-18-cxt-eng).

---

## ⚡ Why Context Engineering 2.0?

Context Engineering 2.0 represents a complete paradigm shift from raw, conversational prompts to structured software engineering workflows. Instead of "vibe-coding" and hoping the LLM gets it right, Context Engineering structures the context, templates, rules, and commands natively within the **Antigravity CLI (agy)** to ensure consistent, reliable, and production-grade code generation.

### Comparison: Vibe Coding vs. Context Engineering 2.0

| Feature | Vibe Coding (Prompt Engineering 1.0) | Context Engineering 2.0 (Antigravity Edition) |
| :--- | :--- | :--- |
| **Workflow** | Sending raw, unstructured prompts in chat. | Executing compiled, structured specifications (PRPs). |
| **Code Quality** | Prone to over-engineered blocks and dependency bloat. | Minimalist, spec-driven code restricted by toggleable guidelines (Ponytail mode). |
| **Interaction** | Constant conversational fluff and back-and-forth. | Native, non-interactive action blocks and precise file diffs. |
| **Context Management** | Context drift as the conversation grows. | Unified, project-specific rulesets and slash commands natively registered in `agy`. |

---

## 📦 Quick Installation

Install the unified plugin natively in your terminal with a single command:

```shell
agy plugin install https://github.com/Apoo711/Context-Engineering
```

---

## 🛠️ The Core Toolkit (Commands)

The suite registers two native slash commands directly into your `agy` environment to manage the lifecycle of your features:

### 1. `/generate-prp`
Generates a rigid, comprehensive **Product Requirements Prompt (PRP)** template based on a simple user request. It forces the AI to plan edge cases, testing gates, and structures before writing a single line of code.

### 2. `/execute-prp`
Executes a compiled PRP spec sheet. It uses strict, non-interactive action blocks to cleanly modify or create files without conversational fluff.

---

## 💇 Toggleable Ponytail Mode (Minimalist Coding)

Tired of AI agents pulling down heavy third-party libraries for trivial tasks? **Ponytail Mode** is our built-in minimalist coding guidelines ruleset. 

The philosophy is simple: **"Lazy, not negligent."** Ponytail mode forces the agent to exhaustively evaluate standard libraries and native browser features before introducing external dependencies.

### How to Enable
You can configure Ponytail Mode by editing the `enable_ponytail_mode` setting in your `plugin.json`:

```json
{
  "settings": {
    "enable_ponytail_mode": true
  }
}
```

Alternatively, you can toggle it interactively through the visual `/config` menu in `agy` or update it in your global settings.

---

## 🗺️ Roadmap

Here is where the Context Engineering Suite is heading next:

- **Progressive Agent Personas:** Toggle between specialized agent profiles (e.g., Greenfield Builder vs. Hardened-Security Auditor).
- **Auto-Verification Test Hooks:** Post-invocation validation gates that automatically run your test suites to verify generated code correctness.
- **Visual Workspace Indexing (`/context-map`):** Auto-generate interactive dependency and architecture maps directly in your terminal.

---

## 🤝 Acknowledgements

This project's workflow and foundational concepts were inspired by the original [Context-Engineering-Intro](https://github.com/coleam00/context-engineering-intro) repository by **coleam00**. While the codebase has transitioned into a native Antigravity CLI plugin, the core vision of spec-driven AI development remains.