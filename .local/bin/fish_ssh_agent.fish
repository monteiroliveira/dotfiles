#!/bin/fish

function sshagent_findsockets # Find agent file in /tmp if exist
	find /tmp -uid (id -u) -type s -name "agent.*" 2> /dev/null
end

function sshagent_testsocket
    if [ X"$argv[1]" != X ] ; # Set agent sock and pid
    	set -xg SSH_AUTH_SOCK $argv[1]
		set -xg SSH_AGENT_PID $(echo $SSH_AUTH_SOCK | cut -d '/' -f4- | sed -e 's/agent.//g')
    end

    if [ X"$SSH_AUTH_SOCK" = X ]
    	return 2
    end

    if [ -S $SSH_AUTH_SOCK ] ;
        ssh-add -l > /dev/null
        if [ $status = 2 ] ;
            echo "Socket $SSH_AUTH_SOCK is dead!  Deleting!"
            rm -f $SSH_AUTH_SOCK
            return 4
        else ;
            echo "Found ssh-agent $SSH_AUTH_SOCK" > /dev/null
            return 0
        end
    else ;
        echo "$SSH_AUTH_SOCK is not a socket!"
        return 3
    end
end

function ssh_agent_init
    set -l AGENTFOUND 0

    if sshagent_testsocket ;
        set AGENTFOUND 1
    end

    if [ $AGENTFOUND = 0 ];
        for agentsocket in (sshagent_findsockets)
            if [ $AGENTFOUND != 0 ] ;
	            break
            end
            if sshagent_testsocket $agentsocket ;
	        	set AGENTFOUND 1
	        end
        end
    end

	set -l AGENT_RUN_STATE $(ssh-add -l > /dev/null 2>&1; echo $status) # = 1 agent is without key | = 0 is running with key | = 2 agent is not running

	# Existing agent not found
    if [ $AGENTFOUND = 0 ] ;
		echo "Need to start a new agent."
		eval (ssh-agent -c)
		echo "Adding a key to new agent:"
		ssh-add
    end

	if [ $AGENTFOUND = 1 ] && [ $AGENT_RUN_STATE = 1 ] ;
		echo "Agent is running without key"
		ssh-add
	end
end

function ssh_agent_status
		echo $SSH_AUTH_SOCK
		echo $SSH_AGENT_PID
		ssh-add -l
end

ssh_agent_init
