# ⚡ Google Forms QA Automation Tool

A PowerShell-based automation tool designed to test Google Forms using automatically generated synthetic test data.

The project demonstrates how PowerShell and HTTP requests can be used to automate repetitive form testing, validate submissions, and monitor test results.

## 🚀 Features

- Automated Google Forms test submissions
- Randomized synthetic test data
- Multiple question types supported
- HTTP POST request automation
- Real-time submission progress
- Success and failure detection
- Error handling
- Configurable number of test submissions
- Configurable delay between submissions
- Clean PowerShell terminal output

## 🛠️ Technologies Used

- PowerShell
- Google Forms
- HTTP Requests
- Workflow Automation
- QA / Test Automation

## ⚙️ How It Works

The script generates synthetic customer feedback data and maps each value to the corresponding Google Forms field.

The workflow is:

Google Form → Synthetic Test Data → PowerShell → HTTP POST → Google Forms → Response Validation

Each submission is checked and the result is displayed directly in the terminal.

Example:

    [1/10] Generating synthetic test response...

    Customer Type : Returning customer
    Service       : Automation
    Satisfaction  : 5/5
    Quality       : Excellent

    [OK] TEST SUBMISSION SUCCESSFUL

After all tests are completed, the program displays a final report:

    Successful : 10
    Failed     : 0
    Total      : 10

## 🎯 Purpose

This project was created to demonstrate automated QA testing and workflow automation for online forms.

It can be useful for testing form behavior, validating field mappings, generating synthetic QA data, and reducing repetitive manual testing.

## 🔒 Responsible Use

This project is intended only for forms that you own or have explicit permission to test.

Synthetic responses should be clearly identified as test data and should not be used to manipulate surveys, research results, polls, or other real-world datasets.

## 👨‍💻 Developer

Developed by **Nour Ben Fekih Ahmed**

Software Engineering Student | Web Development | Automation | AI-Assisted Development
