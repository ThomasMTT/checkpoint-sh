# Bash Checkpoint Script

## Overview
This script implements a checkpoint system for a bash script, allowing it to resume from the last successful checkpoint if the script exits or is interrupted. This is useful for scripts that perform long-running or complex tasks where restarting from the beginning upon failure would be inefficient or undesirable.

## Components
- **Checkpoints**: A list of predefined checkpoints (`Checkpoint1`, `Checkpoint2`, `Checkpoint3`) that represent significant steps in the script's workflow.
- **Checkpoint File**: A file (`/tmp/CHECKPOINT`) where the last completed checkpoint is stored. This allows the script to know where to resume from on the next run.
- **Functions**: The script defines functions for each checkpoint, with logic to update the checkpoint file and perform the necessary operations for each checkpoint.


## Usage
To use this script, simply give it permissions if needed and run it in a bash environment:

```bash
chmod +x ./checkpoint.sh ; ./checkpoint.sh
```

The script will:
1. Determine the last completed checkpoint by reading the checkpoint file.
2. Start from the checkpoint after the last completed one.
3. Proceed through the checkpoints in the defined order.
4. If interrupted, the script will remember the last completed checkpoint, allowing it to resume from that point upon re-run.
5. If the script completes all checkpoints, it will clean up the checkpoint file.

## Notes
- You can define additional checkpoints by adding more entries to the `CHECKPOINTS` array and creating corresponding functions.
- If you want to start over from the beginning, ensure the checkpoint file is deleted or run the `cleanup()` function to clear it.
- To stop at any point, you can use `Ctrl-C`. Upon rerunning, the script will start from the last completed checkpoint.
