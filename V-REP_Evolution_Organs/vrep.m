% Evaluate morphology
function robot_pos = vrep()
     %% Make connection
    disp('Program started');
    vrep=remApi('remoteApi'); % using the prototype file (remoteApiProto.m)
    vrep.simxFinish(-1); % just in case, close all opened connections
    clientID=vrep.simxStart('127.0.0.1',19997,true,true,5000,5);
    pause(2);
    % Open scene to prevent overload of objects
    vrep.simxLoadScene(clientID, '../V-REP_Matlab_2/EvolMor.ttt', 0, vrep.simx_opmode_blocking);
    pause(1);
    if (clientID>-1)
        disp('Connected to remote API server');
        vrep.simxStartSimulation(clientID, vrep.simx_opmode_oneshot);   % Start simulation
        pause(0.7); % Min 0.2
        %% Get robot handle
        [res_Han,robot_handle] = vrep.simxGetObjectHandle(clientID, ...
            'robot_shape', vrep.simx_opmode_blocking); 
        if (res_Han==vrep.simx_return_ok)
            fprintf('Get robot handle success: %d\n', robot_handle);
        else
            fprintf('Get robot handle fail\n');
        end
        %% Get motor handles
        [res_jon(1),motor_handle(1)] = vrep.simxGetObjectHandle(clientID, ...
            'motor1', vrep.simx_opmode_blocking); 
        [res_jon(2),motor_handle(2)] = vrep.simxGetObjectHandle(clientID, ...
            'motor2', vrep.simx_opmode_blocking); 
        %% Debugg
        for i=1:2
            if (res_jon(i)==vrep.simx_return_ok)
                fprintf('Get joint handle success: %d\n', motor_handle(i));
            else
                fprintf('Get joint handle fail. Error: %d\n', res_jon(i));
            end
        end
        %% Set velocities
        for i=1:2
            res_jon(i) = vrep.simxSetJointTargetVelocity(clientID, ...
                motor_handle(i), 10, vrep.simx_opmode_oneshot);
%             res_jon(i) = vrep.simxSetJointTargetVelocity(clientID, ...
%                 motor_handle(i), 10, vrep.simx_opmode_streaming );
        end
        %% Debugg
        for i=1:2
            if (res_jon(i)==vrep.simx_return_ok)
                fprintf('Set velocity success: %d\n', motor_handle(i));
            else
                fprintf('Get velocity fail. Error: %d\n', res_jon(i));
            end
        end
        %% Initialize timer
        tic
        %% Run simulation for N seconds
        while (toc < 10)      
        end
        %% Stop robot
        for i=1:2
            res_jon(i) = vrep.simxSetJointTargetVelocity(clientID, motor_handle(i), 0, ...
                vrep.simx_opmode_oneshot);
        end
        %% Debugg
        for i=1:2
            if (res_jon(i) == vrep.simx_return_ok)
                fprintf('Set velocity success: %d\n', motor_handle(i));
            else
                fprintf('Get velocity fail. Error: %d\n', res_jon(i));
            end
        end 
        %% Retrieve position
        [res_object, object_pos] = vrep.simxGetObjectPosition(clientID, ...
            robot_handle, -1, vrep.simx_opmode_blocking); % Try to retrieve the streamed data
        robot_pos = object_pos(1);
        %% Debugg
        if (res_object==vrep.simx_return_ok) % After initialization of streaming, it will take a few ms before the first value arrives, so check the return code
            fprintf('Robot position x: %2.2d\n',object_pos(1)); 
        else
            fprintf('Retrieve pos fail. Error: %d\n', res_object); 
        end
        %% Stop simulation
        % Before closing the connection to V-REP, make sure that the last command sent out had time to arrive. You can guarantee this with (for example):
        vrep.simxStopSimulation(clientID, vrep.simx_opmode_oneshot); % Stop simulation;
        vrep.simxGetPingTime(clientID);
        % Close scene
        vrep.simxCloseScene(clientID, vrep.simx_opmode_blocking);
        pause(1);
        % Now close the connection to V-REP:    
        vrep.simxFinish(clientID);
    else
        disp('Failed connecting to remote API server');
    end
    vrep.delete(); % call the destructor!
    
    disp('Program ended');
end
