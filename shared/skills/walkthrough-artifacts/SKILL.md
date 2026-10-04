---
name: walkthrough-artifacts
description: >-
  Create walkthrough artifacts (screenshots and screen recordings) that prove
  code changes work. Use when finishing tested changes and uploading demo
  evidence for the user.
environments:
  - cloud
---
# Creating & Uploading Walkthrough Artifacts

When your changes are complete, and you have completed testing / validation, you MUST demonstrate to the user that your changes are working.

If the user explicitly requested specific manual testing, you MUST also demonstrate that you fulfilled their request.

Do this with **walkthrough artifacts**. Follow this rubric, then include HTML-tag references to the artifacts inline in your final response to the user.

## When to Use

Use walkthrough artifacts to: (1) demonstrate that your code changes work correctly, and (2) show that any user-requested manual testing was completed.

## What makes a good test artifact

Good walkthrough artifacts clearly show the user that your code is fully working and any specifically requested testing was completed. Examples:

- A screenshot of an implemented UI change
- A screen recording of changes working end-to-end
- A screen recording or screenshot showing that user-requested testing was performed

The following are examples of bad walkthrough artifacts and should NOT be uploaded:

- A screen recording of a test which ultimately did not succeed. Instead of saving the video, you should fix the failure and retry!
- Numerous screenshots of unimportant setup steps, app exploration, or failing testing steps. You may take these screenshots during testing, but do NOT upload them as artifacts.
- Redundant walkthrough artifacts which show something that a different artifact of the same type already shows.
- A toy artifact or fake / contrived example to "demonstrate" working code. NEVER create toy artifacts or fake / contrived examples.

RULE: Upload the minimal set of artifacts that demonstrates your changes fully work and that all user requests were fulfilled. Videos are often helpful for showing end-to-end tests with fewer artifacts.

Examples of good artifact sets:

- One screenshot showing the final state after testing, and 1 or 2 screen recordings which begins right before demonstrating a working test and ends right after.
- A few screenshots showing the before, during, and after state during your manual tests.
- One screenshot showing key pre-test setup (e.g. altering the application settings, switching the mode, or selecting a specific model), and one screenshot or showing the after test state (or one video showing end-to-end test, minus lengthy setup steps)

If the user requested specific testing (e.g. reproducing a bug before fixing, specific setup steps, testing a feature in a particular way, etc.), you must include clearly-labeled artifacts showing that you completed the user's request(s).

**Remember**: the set of uploaded artifacts must demonstrate BOTH that your code successfully implements the user's request AND that any user-requested testing was completed. Some artifacts may show that both are true, and others may show only one or the other.

Examples of bad sets of artifacts to upload (DO NOT UPLOAD ARTIFACTS LIKE THIS):

- A screenshot before and/or after every testing step
- Screenshots of irrelevant application state, e.g. pre-test state, or state after the relevant portion of the application has been exited or scrolled offscreen.
- Screenshots or videos showing failing tests. Fix these and retry! Do not upload!
- Redundant screenshots which show the same or very similar application states.
- Very lengthy videos which include irrelevant devex setup or application setup state. Start your recording right before the test begins!

## Creating an artifact

### Screenshot artifacts

When you are using the `computerUse` subagent, it will return screenshots showing key application states. Remember these screenshot paths for future use. You should review all available artifacts at the end of your tests and decide which ones best demonstrate the correctness of your code. Show these top artifacts to the user.

### Video artifacts

Video walkthroughs of working features are often the most effective way to demonstrate the correctness of your changes. When you are performing manual GUI-based testing, you MUST include a video artifact.

How to create a video artifact:

1. Setup the manual test environment. This means using the `computerUse` subagent to make sure the UI is open, and navigated to the correct page or feature to demonstrate the working change(s).
2. Begin a recording using the `RecordScreen` tool with mode set to `START_RECORDING`.
3. Perform the manual test that demonstrates the working change(s) using the `computerUse` subagent. Provide detailed instructions for the subagent to follow.
4. Immediately after the `computerUse` subagent responds, end the video recording. If the walkthrough was successful: save the recording to your artifacts directory by using the `RecordScreen` tool with mode set to `SAVE_RECORDING` (this will also stop the recording). If the walkthrough was unsuccessful: discard the recording by using the `RecordScreen` tool with mode set to `DISCARD_RECORDING`. Debug why the walkthrough attempt did not succeed, fix the issue, and retry.

Correct process for creating a video artifact: start recording, start `computerUse` subagent with detailed instructions, end recording.

**Critical Rules:**

- Always end your recording right after your manual test(s) end. If debugging, additional setup, resetting state, or other non-testing steps are required between multiple tests, split the multiple tests into multiple recordings.

## Saving an artifact

To save a screenshot, copy the screenshot to your artifacts directory (the absolute path given in the system prompt under "Creating & Uploading Walkthrough Artifacts"). It is probably advantageous to review and select the most relevant screenshots at the end of your testing.

Screen recordings are auto-saved to that same artifacts directory when RecordScreen is called with mode=SAVE_RECORDING. Only use mode=SAVE_RECORDING when you want the recording to be a user-facing artifact.

Before referencing video artifacts in your response, use the `videoReview` subagent to verify your understanding of what the video shows.

All files placed in that folder will be automatically uploaded when you finish your work and will be visible by the user in the Codex web app.

### Details

- Give files descriptive (but short) names in snake_case, such as screenshot_button_color_before.png and screenshot_button_color_after.png, to help the user understand what the files are.
- For video files, the file name MUST describe the contents of the entire video, not just a part of it.
- Artifact files are immutable and cannot be edited or deleted once uploaded. Don't try to edit or overwrite artifact files, always add a new file in the directory with a unique name.
- All file types are supported.
