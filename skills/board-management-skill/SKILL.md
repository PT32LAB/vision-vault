---
name: board-management
description: Skill for interacting with a Git-based task board that uses submodules for project code.
---

# Board Management Skill

You are operating within a Git repository that acts as a collaborative task management "Board". You and other human developers or AI agents use this Board to coordinate work. The actual application code you will modify is contained within **Git submodules** linked in this repository.

To be an effective collaborator, you must follow the strict workflow below.

## 1. Board Structure

The Board repository contains a `board/` (or `.polyphony/board/`) directory with the following states:
- `todo/`: Tasks waiting to be picked up.
- `in-progress/`: Tasks actively being worked on.
- `review/`: Completed tasks awaiting human review.
- `done/`: Accepted tasks.
- `cancelled/`: Skipped or rejected tasks.

## 2. Picking Up a Task

Before modifying any code, you must "claim" your task to prevent others from doing duplicate work.

1. Find your assigned task markdown file in the `todo/` directory (e.g., `board/todo/MYTASK-001.md`).
2. Append a pickup comment at the end of the file indicating you are starting to work on it:
   ```markdown
   <!-- <comment type="pickup" agent="YOUR_AGENT_NAME"> -->
   I am starting work on this task.
   <!-- </comment> -->
   ```
3. Move the file via git:
   ```bash
   git mv board/todo/MYTASK-001.md board/in-progress/MYTASK-001.md
   ```
4. Commit the change to the Board repository:
   ```bash
   git commit -m "board: MYTASK-001 todo -> in-progress (pickup)"
   ```
5. (Optional but recommended) Push the change so humans and other agents see you claimed it.

## 3. Working in Submodules

The actual project source code may live inside Git submodules located within the current repository. If that's the case:

1. Ensure the submodule is updated:
   ```bash
   git submodule update --init --recursive
   ```
2. Navigate (`cd`) into the appropriate submodule directory.
3. Make your needed code changes, run tests, and verify your implementation.
4. Stage and commit your changes **inside the submodule**:
   ```bash
   cd path/to/submodule
   git add .
   git commit -m "feat: implement MYTASK-001 acceptance criteria"
   # Push the submodule changes
   git push origin main
   ```
Note: You must push the submodule changes *before* committing the Board update, otherwise the Board will point to a submodule commit that no one else can fetch!

## 4. Completing the Task

Once the code in the submodule is committed and pushed, you return to the root Board repository to finalize the task.

1. Navigate back to the root of the Board repository.
2. Edit the task file in `board/in-progress/` to append your completion report (summary of what was done):
   ```markdown
   <!-- <comment type="completion_report" agent="YOUR_AGENT_NAME"> -->
   I have implemented the required endpoints. Tests are passing.
   <!-- </comment> -->
   ```
3. Move the task document to the review stage:
   ```bash
   git mv board/in-progress/MYTASK-001.md board/review/MYTASK-001.md
   ```
4. **Crucial:** Stage both the moved task file AND the updated submodule pointer. The Board repository tracks the specific commit of the submodule.
   ```bash
   git add board/
   git add path/to/submodule
   ```
5. Commit and push the Board repository:
   ```bash
   git commit -m "board: MYTASK-001 in-progress -> review"
   git push origin main
   ```

By successfully pushing the Board repository at the end, continuous integration tools, orchestrators, and humans will be notified that your task is ready for review.
