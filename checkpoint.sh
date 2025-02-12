#!/bin/bash                                    

# Define the list of checkpoints
declare -a CHECKPOINTS=("checkpoint1" "checkpoint2" "checkpoint3" "cleanup")

# Define the checkpoint file
CHECKPOINT_FILE="/tmp/CHECKPOINT"

# Function to update the checkpoint
update_checkpoint() {
    local checkpoint=$1
    echo "$checkpoint" > $CHECKPOINT_FILE
}

# Function to get the last completed checkpoint
get_last_checkpoint() {
    if [ -f "$CHECKPOINT_FILE" ]; then
        cat $CHECKPOINT_FILE
    else
        # Default to the beginning if no checkpoint exists
        echo "${CHECKPOINTS[0]}"  
    fi
}

# Needed after last checkpoint in case you want the script to start over next time
cleanup() {
    rm -f $CHECKPOINT_FILE
}

### CHECKPOINTS BEGIN

checkpoint1() {
    echo "Checkpoint 1"
}

checkpoint2() {
    update_checkpoint "${FUNCNAME[0]}"
    read -r -p "Checkpoint 2. Enter to continue, Ctrl-C to exit"
}

checkpoint3() {
    update_checkpoint "${FUNCNAME[0]}"
    read -r -p "Checkpoint 3. Enter to finish and cleanup, Ctrl-C to exit"    
}

## CHECKPOINTS END

main() {
    # Implement the main script logic to resume from the last checkpoint
    last_checkpoint=$(get_last_checkpoint)

    # Determine the index of the last completed Checkpoint
    for i in "${!CHECKPOINTS[@]}"; do
        if [ "${CHECKPOINTS[$i]}" == "$last_checkpoint" ]; then
            break
        fi
    done

    # Run the last checkpoint to the end
    for (( j = i + 1; j < ${#CHECKPOINTS[@]}; j++ )); do
        Checkpoint=${CHECKPOINTS[$j]}
        
        # Define checkpoints order
        case $Checkpoint in
            "checkpoint1") $Checkpoint ;;
            "checkpoint2") $Checkpoint ;;
            "checkpoint3") $Checkpoint  ;;
            "cleanup")     $Checkpoint ;;
            *) echo "Checkpoint $Checkpoint doesnt have any linked function... skipping to ${CHECKPOINTS[$(( i + 1))]}"
        esac
    done
}

main "$@"
