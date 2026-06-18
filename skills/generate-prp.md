You are an expert-level AI software engineer. Your task is to generate a complete Product Requirements Prompt (PRP) based on the provided user request.

**Your output MUST strictly follow the structure and use the exact headings from the template provided below.** Do not invent your own headings or sections. You must fill out every section of the template: `1. Overview`, `2. Success Criteria`, `3. Context & Resources`, `4. Implementation Blueprint`, and `5. Validation Plan`.

Your final output must be ONLY the completed PRP markdown content. Do not include any other text.

--- TEMPLATE TO FOLLOW ---
# Product Requirements Prompt (PRP)
## 1. Overview
- **Feature Name:** _A short, descriptive name for the feature._

- **Objective:** _A one-sentence summary of the goal. What are we building?_

- **Why:** _What user problem does this solve or what value does it create?_

## 2. Success Criteria
_This feature will be considered complete when the following conditions are met. These must be specific and measurable._

- [ ] The code runs without errors.

- [ ] All new unit tests pass.

- [ ] The feature meets all functional requirements described below.

- [ ] The code adheres to the project standards defined in `GEMINI.md`.

## 3. Context & Resources
_This section contains all the information needed to implement the feature correctly._

### 📚 External Documentation:
_List any URLs for libraries, APIs, or tutorials._

- **Resource:** [Link to API Docs]

   - **Purpose:** _Explain which parts are relevant._

### 💻 Internal Codebase Patterns:
_List any existing files or code snippets from this project that should be used as a pattern or inspiration._

- **File:** `path/to/existing_file.py`

 - **Reason:** _Explain what to learn from it (e.g., "Follow the error handling pattern in this file")._

### ⚠️ Known Pitfalls:
_List any critical warnings, rate limits, or tricky logic to be aware of._

- _e.g., "The external API is case-sensitive and requires a specific header."_

## 4. Implementation Blueprint
_This is the step-by-step plan for building the feature._

### Proposed File Structure:
_Show the desired directory tree, highlighting new or modified files._

```
src/
└── new_feature/
├── __init__.py      (new)
└── core_logic.py    (new)
tests/
└── test_new_feature.py  (new)
```

### Task Breakdown:
_Break the implementation into a sequence of logical tasks._

**Task 1: Data Modeling**

- _Define any Pydantic models or data structures needed._

**Task 2: Core Logic**

- _Implement the main business logic. Pseudocode is encouraged here._
```
# Pseudocode for the main function
def main_function(param: str) -> bool:
   # Step 1: Validate the input
   if not param:
      raise ValueError("Input cannot be empty")

   # Step 2: Perform the core action
   result = perform_action(param)

   # Step 3: Return the result
   return result
```
**Task 3: API/CLI Integration**

- _Connect the core logic to the user-facing interface (e.g., a FastAPI route or an `argparse` CLI)._

## 5. Validation Plan
_How we will verify the implementation is correct._

### Unit Tests:
_Describe the specific test cases that need to be created._

- `test_happy_path():` Should succeed with valid input.

- `test_invalid_input():` Should raise a ValueError with bad input.

- `test_api_failure():` Should handle external API errors gracefully.

**Manual Test Command:**  
_Provide a simple command to run to see the feature in action._
```
python src/main.py --parameter "test_value"
```
**Expected Output:**
```
"Success! The feature works as expected."
```
