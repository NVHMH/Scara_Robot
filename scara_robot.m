function varargout = scara_robot(varargin)
% SCARA_ROBOT MATLAB code for scara_robot.fig
%      SCARA_ROBOT, by itself, creates a new SCARA_ROBOT or raises the existing
%      singleton*.
%
%      H = SCARA_ROBOT returns the handle to a new SCARA_ROBOT or the handle to
%      the existing singleton*.
%
%      SCARA_ROBOT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SCARA_ROBOT.M with the given input arguments.
%
%      SCARA_ROBOT('Property','Value',...) creates a new SCARA_ROBOT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before scara_robot_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to scara_robot_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help scara_robot

% Last Modified by GUIDE v2.5 02-Dec-2023 23:06:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @scara_robot_OpeningFcn, ...
                   'gui_OutputFcn',  @scara_robot_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before scara_robot is made visible.
function scara_robot_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to scara_robot (see VARARGIN)

% Choose default command line output for scara_robot
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes scara_robot wait for user response (see UIRESUME)
% uiwait(handles.figure1);
% Setup the robot arm
% --- Outputs from this function are returned to the command line.

global scara

%% Creat DH Matrix
a     = [0.2    0.3     0   0];
alpha = [0      0       0   180];
d     = [0.251  -0.0045       0   -0.0875];
theta = [0      0       0   0];

%%
base = [0; 0; 0];
type = ['r', 'r', 'p', 'r']; % xoay, xoay, truot, xoay
scara = arm(a, alpha, d, theta, base, type);
scara = scara.set_joint_variable(1, deg2rad(get(handles.slider1, 'Value')));
scara = scara.set_joint_variable(2, deg2rad(-45));
% scara = scara.set_joint_variable(2, deg2rad(get(handles.slider2, 'Value')));
scara = scara.set_joint_variable(3, get(handles.slider3, 'Value'));
scara = scara.set_joint_variable(4, deg2rad(get(handles.slider4, 'Value')));
scara = scara.update();
set_ee_params(scara, handles);
scara.plot(handles.axes1, get(handles.coordinates_cb,'Value'), get(handles.workspace_cb,'Value'));



%% test

global float pre_th1;
global float th1;
global float pre_th2;
global float th2;
global float pre_th4;
global float th4;
global float pre_d3;
global float d3;
th1 = deg2rad(-54.4864);
th2 = deg2rad(45.027);
d3  = 0;
th4 = deg2rad(324.459);




function varargout = scara_robot_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
%%
% global scara
global float pre_th1;
global float th1;
pre_th1 = th1;
th1 = deg2rad(get(handles.slider1, 'Value'));

handles.theta1.String = get(handles.slider1,'Value'); 

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% --- Executes during object creation, after setting all properties.
%%
% global scara
global float pre_th2;
global float th2;
pre_th2 = th2;
th2 = deg2rad(get(handles.slider2, 'Value'));

handles.theta2.String = get(handles.slider2,'Value'); 
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%%
% global scara
global float pre_d3;
global float d3;
pre_d3 = d3;
d3 = get(handles.slider3, 'Value');

handles.d3.String = get(handles.slider3,'Value'); 
% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
%%
% global scara
global float pre_th4;
global float th4;
pre_th4 = th4;
th4 = deg2rad(get(handles.slider4, 'Value'));

handles.theta4.String = get(handles.slider4,'Value'); 
% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function theta1_Callback(hObject, eventdata, handles)
% hObject    handle to theta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta1 as text
%        str2double(get(hObject,'String')) returns contents of theta1 as a double
%%
% global scara
global float pre_th1;
global float th1;
set(handles.slider1,'Value',str2double(handles.theta1.String));
pre_th1 = th1;
th1 = deg2rad(get(handles.slider1, 'Value'));


% --- Executes during object creation, after setting all properties.
function theta1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function theta2_Callback(hObject, eventdata, handles)
% hObject    handle to theta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta2 as text
%        str2double(get(hObject,'String')) returns contents of theta2 as a double

%%
% global scara
global float pre_th2;
global float th2;
set(handles.slider2,'Value',str2double(handles.theta2.String));
pre_th2 = th2;
th2 = deg2rad(get(handles.slider2, 'Value'));
% --- Executes during object creation, after setting all properties.
function theta2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function d3_Callback(hObject, eventdata, handles)
% hObject    handle to d3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d3 as text
%        str2double(get(hObject,'String')) returns contents of d3 as a double
%%
% global scara
global float pre_d3;
global float d3;
set(handles.slider3,'Value',str2double(handles.d3.String));
pre_d3 = d3;
d3 = get(handles.slider3, 'Value');

% --- Executes during object creation, after setting all properties.
function d3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function theta4_Callback(hObject, eventdata, handles)
% hObject    handle to theta4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta4 as text
%        str2double(get(hObject,'String')) returns contents of theta4 as a double
%%
% global scara
global float pre_th4;
global float th4;
set(handles.slider4,'Value',str2double(handles.theta4.String));
pre_th4 = th4;
th4 = deg2rad(get(handles.slider4, 'Value'));



% --- Executes during object creation, after setting all properties.
function theta4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in motion_btn.
% function DH_table_btn_Callback(hObject, eventdata, handles)
% % hObject    handle to motion_btn (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% global scara
% table((1:scara.n)', scara.a', scara.alpha', scara.d', scara.theta', 'VariableNames', {'Joint', 'a', 'alpha', 'd', 'theta'})
% 


function x_end_Callback(hObject, eventdata, handles)
% hObject    handle to x_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x_end as text
%        str2double(get(hObject,'String')) returns contents of x_end as a double


% --- Executes during object creation, after setting all properties.
function x_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y_end_Callback(hObject, eventdata, handles)
% hObject    handle to y_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y_end as text
%        str2double(get(hObject,'String')) returns contents of y_end as a double


% --- Executes during object creation, after setting all properties.
function y_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function z_end_Callback(hObject, eventdata, handles)
% hObject    handle to z_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of z_end as text
%        str2double(get(hObject,'String')) returns contents of z_end as a double


% --- Executes during object creation, after setting all properties.
function z_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to z_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function roll_end_Callback(hObject, eventdata, handles)
% hObject    handle to roll_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of roll_end as text
%        str2double(get(hObject,'String')) returns contents of roll_end as a double


% --- Executes during object creation, after setting all properties.
function roll_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to roll_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pitch_end_Callback(hObject, eventdata, handles)
% hObject    handle to pitch_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pitch_end as text
%        str2double(get(hObject,'String')) returns contents of pitch_end as a double


% --- Executes during object creation, after setting all properties.
function pitch_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pitch_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yaw_end_Callback(hObject, eventdata, handles)
% hObject    handle to yaw_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yaw_end as text
%        str2double(get(hObject,'String')) returns contents of yaw_end as a double


% --- Executes during object creation, after setting all properties.
function yaw_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yaw_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in coordinates_cb.
function coordinates_cb_Callback(hObject, eventdata, handles)
% hObject    handle to coordinates_cb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of coordinates_cb
%%
global scara
scara.plot(handles.axes1, get(handles.coordinates_cb,'Value'), get(handles.workspace_cb,'Value'));


% --- Executes on button press in motion_btn.
function motion_btn_Callback(hObject, eventdata, handles)
% hObject    handle to motion_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%
global scara
global float pre_th1;
global float th1;
global float pre_th2;
global float th2;
global float pre_th4;
global float th4;
global float pre_d3;
global float d3;
global float qmax_th1;
global float qmax_th2;
global float qmax_d3;
global float qmax_th4;

qmax_th1 = abs(th1 - pre_th1);
qmax_th2 = abs(th2 - pre_th2);
qmax_d3 = abs(d3 - pre_d3);
qmax_th4 = abs(th4 - pre_th4);

[t_th1, q_th1, v_th1, a_th1] = LSPB_trajectory(qmax_th1, 10, 300);
[t_th2, q_th2, v_th2, a_th2] = LSPB_trajectory(qmax_th2, 10, 300);
[t_d3, q_d3, v_d3, a_d3] = LSPB_trajectory(qmax_d3, 0.5, 10);
[t_th4, q_th4, v_th4, a_th4] = LSPB_trajectory(qmax_th4, 20, 300);

%Call time of effector
t1 = t_th1(length(t_th1));
t2 = t_th2(length(t_th2));
t3 = t_d3(length(t_d3));
t_e = [t_th1 t1+t_th2 t1+t2+t_d3 t1+t2+t3+t_th4];
%clear 
cla(handles.axes_qe);
cla(handles.axes_ve);
cla(handles.axes_ae);
cla(handles.axes_q1);
cla(handles.axes_v1);
cla(handles.axes_a1);
cla(handles.axes_q2);
cla(handles.axes_v2);
cla(handles.axes_a2);
cla(handles.axes_q3);
cla(handles.axes_v3);
cla(handles.axes_a3);
cla(handles.axes_q4);
cla(handles.axes_v4);
cla(handles.axes_a4);

%Joint 1 motion
for i = 1: length(t_th1)
    plot(handles.axes_q1, t_th1(1:i), q_th1(1,1:i), 'b-');
    plot(handles.axes_v1, t_th1(1:i), v_th1(1,1:i), 'b-');
    plot(handles.axes_a1, t_th1(1:i), a_th1(1,1:i), 'b-');
    pause(t_th1(length(t_th1))/length(t_th1));
end
%Joint 2 motion
for i = 1: length(t_th2)
    plot(handles.axes_q2, t_th2(1:i), q_th2(1,1:i), 'b-');
    plot(handles.axes_v2, t_th2(1:i), v_th2(1,1:i), 'b-');
    plot(handles.axes_a2, t_th2(1:i), a_th2(1,1:i), 'b-');
    pause(t_th2(length(t_th2))/length(t_th2));
end
%Joint 3 motion
for i = 1: length(t_d3)
    plot(handles.axes_q3, t_d3(1:i), q_d3(1,1:i), 'b-');
    plot(handles.axes_v3, t_d3(1:i), v_d3(1,1:i), 'b-');
    plot(handles.axes_a3, t_d3(1:i), a_d3(1,1:i), 'b-');
    pause(t_d3(length(t_d3))/length(t_d3));
end
%Joint 4 motion
for i = 1: length(t_th4)
    plot(handles.axes_q4, t_th1(1:i), q_th4(1,1:i), 'b-');
    plot(handles.axes_v4, t_th1(1:i), v_th4(1,1:i), 'b-');
    plot(handles.axes_a4, t_th1(1:i), a_th4(1,1:i), 'b-');
    pause(t_th4(length(t_th4))/length(t_th2));
end


% for i = 1:1000
%     scara = scara.set_joint_variable(1, vec_th1(i));
%     scara = scara.set_joint_variable(2, vec_th2(i));
%     scara = scara.set_joint_variable(3, vec_d3(i));
%     scara = scara.set_joint_variable(4, vec_th4(i));
%     scara = scara.update();
%     scara.plot(handles.axes1, get(handles.coordinates_cb,'Value'), get(handles.workspace_cb,'Value'));    
% end   
% set_ee_params(scara, handles);








function x_start_Callback(hObject, eventdata, handles)
% hObject    handle to x_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x_start as text
%        str2double(get(hObject,'String')) returns contents of x_start as a double


% --- Executes during object creation, after setting all properties.
function x_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y_start_Callback(hObject, eventdata, handles)
% hObject    handle to y_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y_start as text
%        str2double(get(hObject,'String')) returns contents of y_start as a double


% --- Executes during object creation, after setting all properties.
function y_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function z_start_Callback(hObject, eventdata, handles)
% hObject    handle to z_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of z_start as text
%        str2double(get(hObject,'String')) returns contents of z_start as a double


% --- Executes during object creation, after setting all properties.
function z_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to z_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function roll_start_Callback(hObject, eventdata, handles)
% hObject    handle to roll_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of roll_start as text
%        str2double(get(hObject,'String')) returns contents of roll_start as a double


% --- Executes during object creation, after setting all properties.
function roll_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to roll_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pitch_start_Callback(hObject, eventdata, handles)
% hObject    handle to pitch_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pitch_start as text
%        str2double(get(hObject,'String')) returns contents of pitch_start as a double


% --- Executes during object creation, after setting all properties.
function pitch_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pitch_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yaw_start_Callback(hObject, eventdata, handles)
% hObject    handle to yaw_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yaw_start as text
%        str2double(get(hObject,'String')) returns contents of yaw_start as a double


% --- Executes during object creation, after setting all properties.
function yaw_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yaw_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in workspace_cb.
function workspace_cb_Callback(hObject, eventdata, handles)
% hObject    handle to workspace_cb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of workspace_cb
global scara
scara.plot(handles.axes1, get(handles.coordinates_cb,'Value'), get(handles.workspace_cb,'Value'));


% --- Executes on button press in inverse_btn.
function inverse_btn_Callback(hObject, eventdata, handles)
% hObject    handle to inverse_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global scara
global float pre_th1;
global float th1;
global float pre_th2;
global float th2;
global float pre_th4;
global float th4;
global float pre_d3;
global float d3;
%end_effector
p0 = zeros(1, 6);
p0(1) = str2double(get(handles.x_start, 'String'));
p0(2) = str2double(get(handles.y_start, 'String'));
p0(3) = str2double(get(handles.z_start, 'String'));
p0(4) = deg2rad(str2double(get(handles.roll_start, 'String')));
p0(5) = deg2rad(str2double(get(handles.pitch_start, 'String')));
p0(6) = deg2rad(str2double(get(handles.yaw_start, 'String')));

joint = inverse_kinematics(scara.a, scara.alpha, scara.d, scara.theta, p0);

pre_th1 = th1;
pre_th2 = th2;
pre_d3  = d3;
pre_th4 = th4;

th1 = joint(1);
th2 = joint(2);
d3  = joint(3);
th4 = joint(4);

set(handles.slider1,'Value',rad2deg(th1));
handles.theta1.String = get(handles.slider1,'Value');
set(handles.slider2,'Value',rad2deg(th2));
handles.theta2.String = get(handles.slider2,'Value');
set(handles.slider3,'Value',d3);
handles.d3.String = get(handles.slider3,'Value');
set(handles.slider4,'Value',rad2deg(th4));
handles.theta4.String = get(handles.slider4,'Value');


% --- Executes on selection change in Select_joint.
% function Select_joint_Callback(hObject, eventdata, handles)
% % hObject    handle to Select_joint (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: contents = cellstr(get(hObject,'String')) returns Select_joint contents as cell array
% %        contents{get(hObject,'Value')} returns selected item from Select_joint
% %%
% contents = cellstr(get(handles.Select_joint, 'String'));
% space_plot_type = contents{get(handles.Select_joint, 'Value')};
% if strcmp(space_plot_type, 'Joint 1')
%     set(handles.Joint_1, 'Visible', 'on');
%     set(handles.Joint_2, 'Visible', 'off');
%     set(handles.Joint_3, 'Visible', 'off');
%     set(handles.Joint_4, 'Visible', 'off');
% elseif strcmp(space_plot_type, 'Joint 2')
%     set(handles.Joint_1, 'Visible', 'off');
%     set(handles.Joint_2, 'Visible', 'on');
%     set(handles.Joint_3, 'Visible', 'off');
%     set(handles.Joint_4, 'Visible', 'off');
% elseif strcmp(space_plot_type, 'Joint 3')
%     set(handles.Joint_1, 'Visible', 'off');
%     set(handles.Joint_2, 'Visible', 'off');
%     set(handles.Joint_3, 'Visible', 'on');
%     set(handles.Joint_4, 'Visible', 'off');
% elseif strcmp(space_plot_type, 'Joint 4')
%     set(handles.Joint_1, 'Visible', 'off');
%     set(handles.Joint_2, 'Visible', 'off');
%     set(handles.Joint_3, 'Visible', 'off');
%     set(handles.Joint_4, 'Visible', 'on');
% end

% --- Executes during object creation, after setting all properties.
function Select_joint_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Select_joint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
