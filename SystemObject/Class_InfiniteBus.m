% This class is currently discarded, and should not be used!
% This class defines the model of an infinite bus.

% Notes: An infinite bus is short-circuit in small-signal analysis.

% Author(s): Yitong Li

classdef Class_InfiniteBus < Class_Model_Advance
    
    methods(Static)
        
        % Set the strings of state, input, output
        function SetString(obj)
            obj.StateString  = {'theta'};           	% x
         	obj.InputString  = {'i_d','i_q'};           % u
        	obj.OutputString = {'v_d','v_q','w','theta'};  	% y
        end
        
        % Calculate the equilibrium
        function Equilibrium(obj)
         	% Get the power PowerFlow values
            P 	= obj.PowerFlow(1);
            Q	= obj.PowerFlow(2);
            V	= obj.PowerFlow(3);
            xi	= obj.PowerFlow(4);
            w   = obj.PowerFlow(5);
            
            % Calculate
            v_d = V;
            v_q = 0;
            i_d = P/V;
            i_q = -Q/V;
            
            obj.u_e = [i_d; i_q];
            obj.x_e = [];
            obj.xi = [xi];
        end
        
        % State space model
        function [Output] = StateSpaceEqu(obj,x,u,CallFlag)     
            w	= obj.PowerFlow(5);
            if CallFlag == 1
                dtheta = w;
              	f_xu = [dtheta];
                Output = f_xu;
            elseif CallFlag == 2
                % Output equations: y = g(x,u)
                v_d = 0;
                v_q = 0;
                g_xu = [v_d; v_q; w];
                Output = g_xu;              
            end
        end
        
    end
end