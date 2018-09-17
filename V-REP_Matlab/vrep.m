% Make sure to have the server side running in V-REP: 
% in a child script of a V-REP scene, add following command
% to be executed just once, at simulation start:
%
% simRemoteApi.start(19999)
%
% then start simulation, and run this program.
%
% IMPORTANT: for each successful call to simxStart, there
% should be a corresponding call to simxFinish at the end!

function robot_pos = vrep()
    
    %% Make connection
    disp('Program started');
    vrep=remApi('remoteApi'); % using the prototype file (remoteApiProto.m)
    vrep.simxFinish(-1); % just in case, close all opened connections
    clientID=vrep.simxStart('127.0.0.1',19997,true,true,5000,5);

    if (clientID>-1)
        disp('Connected to remote API server');
        vrep.simxStartSimulation(clientID, vrep.simx_opmode_oneshot);   % Start simulation
        pause(2);
        %% Get robot handle
        [res_Han,robot_handle] = vrep.simxGetObjectHandle(clientID, ...
            'robot_shape', vrep.simx_opmode_blocking); 
        if (res_Han==vrep.simx_return_ok)
            fprintf('Get robot handle success: %d\n', robot_handle);
        else
            fprintf('Get robot handle fail\n');
        end
       %  [res_Han,wheel_handle] = vrep.simxGetObjectHandle(clientID, ...
       %     'robot_left_back_wheel', vrep.simx_opmode_blocking); 
%        res_pos = vrep.simxSetObjectPosition(clientID, robot_handle, -1, ...
%             [0.2, 0.2, 0.10], vrep.simx_opmode_oneshot) 
       %res_pos = vrep.simxSetObjectPosition(clientID, wheel_handle, -1, ...
       %     [0.2, 0.2, 0.10], vrep.simx_opmode_oneshot)
        %% Get motor handles
        [res_jon(1),motor_handle(1)] = vrep.simxGetObjectHandle(clientID, ...
            'back_left_motor', vrep.simx_opmode_blocking); 
        [res_jon(2),motor_handle(2)] = vrep.simxGetObjectHandle(clientID, ...
            'back_right_motor', vrep.simx_opmode_blocking); 
        [res_jon(3),motor_handle(3)] = vrep.simxGetObjectHandle(clientID, ...
            'front_left_motor', vrep.simx_opmode_blocking); 
        [res_jon(4),motor_handle(4)] = vrep.simxGetObjectHandle(clientID, ...
            'front_right_motor', vrep.simx_opmode_blocking); 
        %% Debugg
        for i=1:4
            if (res_jon(i)==vrep.simx_return_ok)
                fprintf('Get joint handle success: %d\n', motor_handle(i));
            else
                fprintf('Get joint handle fail\n');
            end
        end
        %% Set velocities
        for i=1:4
            res_jon(i) = vrep.simxSetJointTargetVelocity(clientID, ...
                motor_handle(i), 10, vrep.simx_opmode_oneshot);
        end
        pause(2);
        %% Debugg
        for i=1:4
            if (res_jon(i)==vrep.simx_return_ok)
                fprintf('Set velocity success: %d\n', motor_handle(i));
            else
                fprintf('Get velocity fail\n');
            end
        end
        %% Initialize timer
        t=clock;
        startTime=t(6);
        currentTime=t(6);
        %% Run simulation for N seconds
        while (currentTime-startTime < 5)
            %% Retrieve position
            [res_object, object_pos] = vrep.simxGetObjectPosition(clientID, ...
                robot_handle, -1, vrep.simx_opmode_blocking); % Try to retrieve the streamed data
            robot_pos = object_pos(1);
            %% Debugg
            if (res_object==vrep.simx_return_ok) % After initialization of streaming, it will take a few ms before the first value arrives, so check the return code
                fprintf('Robot position x: %2.2d\n',object_pos(1)); 
            else
                fprintf('Retrieve pos fail \n'); 
            end
            t=clock;
            currentTime=t(6);
        end
        %% Stop robot
        for i=1:4
            res_jon(i) = vrep.simxSetJointTargetVelocity(clientID, motor_handle(i), 0, ...
                vrep.simx_opmode_oneshot);
        end
        %% Debugg
        for i=1:4
            if (res_jon(i) == vrep.simx_return_ok)
                fprintf('Set velocity success: %d\n', motor_handle(i));
            else
                fprintf('Get velocity fail\n');
            end
        end    
        %% Return robot to origin
%         res_pos = vrep.simxSetObjectPosition(clientID, robot_handle, -1, ...
%             [0, 0, 0.10], vrep.simx_opmode_oneshot)
        % Before closing the connection to V-REP, make sure that the last command sent out had time to arrive. You can guarantee this with (for example):
        vrep.simxStopSimulation(clientID, vrep.simx_opmode_oneshot); % Stop simulation
        
        vrep.simxGetPingTime(clientID);

        % Now close the connection to V-REP:    
        vrep.simxFinish(clientID);
    else
        disp('Failed connecting to remote API server');
    end
    vrep.delete(); % call the destructor!
    
    disp('Program ended');
end
