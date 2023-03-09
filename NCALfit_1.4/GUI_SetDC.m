function varargout = GUI_SetDC(varargin)
% GUI_SETDC MATLAB code for GUI_SetDC.fig
%      GUI_SETDC, by itself, creates a new GUI_SETDC or raises the existing
%      singleton*.
%
%      H = GUI_SETDC returns the handle to a new GUI_SETDC or the handle to
%      the existing singleton*.
%
%      GUI_SETDC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_SETDC.M with the given input arguments.
%
%      GUI_SETDC('Property','Value',...) creates a new GUI_SETDC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_SetDC_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_SetDC_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_SetDC

% Last Modified by GUIDE v2.5 05-Jul-2018 17:20:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_SetDC_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_SetDC_OutputFcn, ...
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


% --- Executes just before GUI_SetDC is made visible.
function GUI_SetDC_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_SetDC (see VARARGIN)

% Choose default command line output for GUI_SetDC
handles.output = hObject;

% Take useful information from GUI father (if it exists)
if size(varargin,2) > 0
    oldHandles = varargin{1};
    if isfield(oldHandles,'obj')
        handles.obj = oldHandles.obj;
    end
    sF = oldHandles.sF;
    tWs = oldHandles.tWs;
    oWs = oldHandles.oWs;
    handles.sF = sF;
    handles.tWs = tWs;
    handles.oWs = oWs;
end

% prepare figures
handles.p_t(1) = bar(handles.p_1, 1, 0);
handles.p_t(2) = bar(handles.p_2, 1, 0);
handles.p_t(3) = bar(handles.p_3, 1, 0);
handles.p_t(4) = bar(handles.p_4, 1, 0);
handles.p_t(5) = bar(handles.p_5, 1, 0);
handles.p_t(6) = bar(handles.p_6, 1, 0);
handles.p_t(7) = bar(handles.p_7, 1, 0);
handles.p_t(8) = bar(handles.p_8, 1, 0);
handles.p_t(9) = bar(handles.p_9, 1, 0);
handles.p_t(10) = bar(handles.p_10, 1, 0);
handles.p_t(11) = bar(handles.p_11, 1, 0);
handles.p_t(12) = bar(handles.p_12, 1, 0);
handles.p_t(13) = bar(handles.p_13, 1, 0);
handles.p_t(14) = bar(handles.p_14, 1, 0);
handles.p_t(15) = bar(handles.p_15, 1, 0);
handles.p_t(16) = bar(handles.p_16, 1, 0);
set(handles.p_1,'Xticklabel','');
set(handles.p_2,'Xticklabel','');
set(handles.p_3,'Xticklabel','');
set(handles.p_4,'Xticklabel','');
set(handles.p_5,'Xticklabel','');
set(handles.p_6,'Xticklabel','');
set(handles.p_7,'Xticklabel','');
set(handles.p_8,'Xticklabel','');
set(handles.p_9,'Xticklabel','');
set(handles.p_10,'Xticklabel','');
set(handles.p_11,'Xticklabel','');
set(handles.p_12,'Xticklabel','');
set(handles.p_13,'Xticklabel','');
set(handles.p_14,'Xticklabel','');
set(handles.p_15,'Xticklabel','');
set(handles.p_16,'Xticklabel','');
set(handles.p_1,'Yticklabel','');
set(handles.p_2,'Yticklabel','');
set(handles.p_3,'Yticklabel','');
set(handles.p_4,'Yticklabel','');
set(handles.p_5,'Yticklabel','');
set(handles.p_6,'Yticklabel','');
set(handles.p_7,'Yticklabel','');
set(handles.p_8,'Yticklabel','');
set(handles.p_9,'Yticklabel','');
set(handles.p_10,'Yticklabel','');
set(handles.p_11,'Yticklabel','');
set(handles.p_12,'Yticklabel','');
set(handles.p_13,'Yticklabel','');
set(handles.p_14,'Yticklabel','');
set(handles.p_15,'Yticklabel','');
set(handles.p_16,'Yticklabel','');
set(handles.p_1,'ylim',[0 1]);
set(handles.p_2,'ylim',[0 1]);
set(handles.p_3,'ylim',[0 1]);
set(handles.p_4,'ylim',[0 1]);
set(handles.p_5,'ylim',[0 1]);
set(handles.p_6,'ylim',[0 1]);
set(handles.p_7,'ylim',[0 1]);
set(handles.p_8,'ylim',[0 1]);
set(handles.p_9,'ylim',[0 1]);
set(handles.p_10,'ylim',[0 1]);
set(handles.p_11,'ylim',[0 1]);
set(handles.p_12,'ylim',[0 1]);
set(handles.p_13,'ylim',[0 1]);
set(handles.p_14,'ylim',[0 1]);
set(handles.p_15,'ylim',[0 1]);
set(handles.p_16,'ylim',[0 1]);
set(handles.ax_ramp,'Xticklabel','');
set(handles.ax_open,'Xticklabel','');
set(handles.ax_close,'Xticklabel','');
set(handles.ax_ramp,'Yticklabel','');
set(handles.ax_open,'Yticklabel','');
set(handles.ax_close,'Yticklabel','');

set(hObject, 'WindowButtonUpFcn', @(hObject,eventdata)GUI_SetDC('stopDragFcn',hObject,eventdata,guidata(hObject)));

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_SetDC wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_SetDC_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function et_nCh_Callback(hObject, eventdata, handles)
% hObject    handle to et_nCh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_nCh as text
%        str2double(get(hObject,'String')) returns contents of et_nCh as a double


% --- Executes during object creation, after setting all properties.
function et_nCh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_nCh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_MVC1_Callback(hObject, eventdata, handles)
% hObject    handle to et_MVC1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_MVC1 as text
%        str2double(get(hObject,'String')) returns contents of et_MVC1 as a double


% --- Executes during object creation, after setting all properties.
function et_MVC1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_MVC1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_selMov1.
function pm_selMov1_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selMov1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selMov1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selMov1


% --- Executes during object creation, after setting all properties.
function pm_selMov1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selMov1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_thresh1_Callback(hObject, eventdata, handles)
% hObject    handle to et_thresh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_thresh1 as text
%        str2double(get(hObject,'String')) returns contents of et_thresh1 as a double


% --- Executes during object creation, after setting all properties.
function et_thresh1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_thresh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_MVC8_Callback(hObject, eventdata, handles)
% hObject    handle to et_MVC8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_MVC8 as text
%        str2double(get(hObject,'String')) returns contents of et_MVC8 as a double


% --- Executes during object creation, after setting all properties.
function et_MVC8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_MVC8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_selMov8.
function pm_selMov8_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selMov8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selMov8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selMov8


% --- Executes during object creation, after setting all properties.
function pm_selMov8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selMov8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_thresh8_Callback(hObject, eventdata, handles)
% hObject    handle to et_thresh8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_thresh8 as text
%        str2double(get(hObject,'String')) returns contents of et_thresh8 as a double


% --- Executes during object creation, after setting all properties.
function et_thresh8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_thresh8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_MVC4_Callback(hObject, eventdata, handles)
% hObject    handle to et_MVC4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_MVC4 as text
%        str2double(get(hObject,'String')) returns contents of et_MVC4 as a double


% --- Executes during object creation, after setting all properties.
function et_MVC4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_MVC4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_selMov4.
function pm_selMov4_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selMov4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selMov4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selMov4


% --- Executes during object creation, after setting all properties.
function pm_selMov4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selMov4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_thresh4_Callback(hObject, eventdata, handles)
% hObject    handle to et_thresh4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_thresh4 as text
%        str2double(get(hObject,'String')) returns contents of et_thresh4 as a double


% --- Executes during object creation, after setting all properties.
function et_thresh4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_thresh4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_MVC7_Callback(hObject, eventdata, handles)
% hObject    handle to et_MVC7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_MVC7 as text
%        str2double(get(hObject,'String')) returns contents of et_MVC7 as a double


% --- Executes during object creation, after setting all properties.
function et_MVC7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_MVC7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_selMov7.
function pm_selMov7_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selMov7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selMov7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selMov7


% --- Executes during object creation, after setting all properties.
function pm_selMov7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selMov7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_thresh7_Callback(hObject, eventdata, handles)
% hObject    handle to et_thresh7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_thresh7 as text
%        str2double(get(hObject,'String')) returns contents of et_thresh7 as a double


% --- Executes during object creation, after setting all properties.
function et_thresh7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_thresh7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_MVC3_Callback(hObject, eventdata, handles)
% hObject    handle to et_MVC3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_MVC3 as text
%        str2double(get(hObject,'String')) returns contents of et_MVC3 as a double


% --- Executes during object creation, after setting all properties.
function et_MVC3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_MVC3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_selMov3.
function pm_selMov3_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selMov3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selMov3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selMov3


% --- Executes during object creation, after setting all properties.
function pm_selMov3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selMov3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_thresh3_Callback(hObject, eventdata, handles)
% hObject    handle to et_thresh3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_thresh3 as text
%        str2double(get(hObject,'String')) returns contents of et_thresh3 as a double


% --- Executes during object creation, after setting all properties.
function et_thresh3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_thresh3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_MVC5_Callback(hObject, eventdata, handles)
% hObject    handle to et_MVC5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_MVC5 as text
%        str2double(get(hObject,'String')) returns contents of et_MVC5 as a double


% --- Executes during object creation, after setting all properties.
function et_MVC5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_MVC5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_selMov5.
function pm_selMov5_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selMov5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selMov5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selMov5


% --- Executes during object creation, after setting all properties.
function pm_selMov5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selMov5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_thresh5_Callback(hObject, eventdata, handles)
% hObject    handle to et_thresh5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_thresh5 as text
%        str2double(get(hObject,'String')) returns contents of et_thresh5 as a double


% --- Executes during object creation, after setting all properties.
function et_thresh5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_thresh5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_MVC6_Callback(hObject, eventdata, handles)
% hObject    handle to et_MVC6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_MVC6 as text
%        str2double(get(hObject,'String')) returns contents of et_MVC6 as a double


% --- Executes during object creation, after setting all properties.
function et_MVC6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_MVC6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_selMov6.
function pm_selMov6_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selMov6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selMov6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selMov6


% --- Executes during object creation, after setting all properties.
function pm_selMov6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selMov6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_thresh6_Callback(hObject, eventdata, handles)
% hObject    handle to et_thresh6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_thresh6 as text
%        str2double(get(hObject,'String')) returns contents of et_thresh6 as a double


% --- Executes during object creation, after setting all properties.
function et_thresh6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_thresh6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_MVC2_Callback(hObject, eventdata, handles)
% hObject    handle to et_MVC2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_MVC2 as text
%        str2double(get(hObject,'String')) returns contents of et_MVC2 as a double


% --- Executes during object creation, after setting all properties.
function et_MVC2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_MVC2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_selMov2.
function pm_selMov2_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selMov2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selMov2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selMov2


% --- Executes during object creation, after setting all properties.
function pm_selMov2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selMov2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_thresh2_Callback(hObject, eventdata, handles)
% hObject    handle to et_thresh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_thresh2 as text
%        str2double(get(hObject,'String')) returns contents of et_thresh2 as a double


% --- Executes during object creation, after setting all properties.
function et_thresh2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_thresh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_startRT.
function pb_startRT_Callback(hObject, eventdata, handles)
% hObject    handle to pb_startRT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    global MVC;
    global chs;
    
    coContractionEnable = get(handles.cb_cocEnable,'Value');
    checkNoiseLevel = get(handles.cb_noiseLevel,'Value'); 
    
    % Selected channels
    chs = [];
    for i = 1 : 16
        chs(i) = get(eval(strcat('handles.cb_',num2str(i))),'Value');
    end
    chIdxExtra = 0;
    chIdxUpper = bitshift(sum(bitset(0,find(chs==1))),-8);
    chIdxLower = bitand(sum(bitset(0,find(chs==1))),255);
    nCh = size(find(chs==1),2);
    
    resetValues = get(handles.cb_reset,'Value');    
    if resetValues
        for i = 1 : 16
            MVC(i) = 0;
            set(eval(strcat('handles.et_MVC',num2str(i))),'String','');
            set(eval(strcat('handles.et_thresh',num2str(i))),'String','');
            set(eval(strcat('handles.s_thresh',num2str(i))),'Value',0);
        end
    end
    
    % Number of Samples
    samples = str2double(get(handles.et_time,'String'));
    
    % Initialization of progress bar
    set(handles.p_1,'YLimMode','manual');
    set(handles.p_2,'YLimMode','manual');
     
    % Get connection object
    if isfield(handles,'obj')
        obj = handles.obj;
    else
        set(handles.t_msg,'String','No connection obj found');   
        return;
    end
    % Set up receiving buffer
    obj.InputBufferSize = 4*16*samples*5;

    % Open the connection
    fopen(obj);
    % Read available data and discard it
    if obj.BytesAvailable > 0
        fread(obj,obj.BytesAvailable,'uint8');    % Read the samples        
    end    
    
    % Set the parameters for features extraction
    % recover tWs and oWs info from GUI father (if it exists)
    if isfield(handles,'sF')
        sF = handles.sF;
    else
        sF = 1000;
    end
    if isfield(handles,'tWs')
        tWs = handles.tWs;
    else
        tWs = 0.05*sF;
    end
    if isfield(handles,'oWs')
        oWs = handles.oWs;
    else   
        oWs = sF*0.025;
    end
    FeaturesEnables(1) = 1;
    FeaturesEnables(2) = 0;
    FeaturesEnables(3) = 0;
    FeaturesEnables(4) = 0;
    FeaturesEnables(5) = 0;
    nFeatures = sum(FeaturesEnables(:));
%     fwrite(obj,'f','char');
%     replay = char(fread(obj,1,'char'));
%     if strcmp(replay,'f')
%         fwrite(obj,tWs,'float');
%         fwrite(obj,oWs,'float');
%         fwrite(obj,nFeatures,'char');
%         for i = 1:size(FeaturesEnables,2)
%             fwrite(obj,FeaturesEnables(i),'char');
%         end
%         replay = char(fread(obj,1,'char'));
%         if strcmp(replay,'f');
%             set(handles.t_msg,'String','Features extraction parameters set');
%         else
%             set(handles.t_msg,'String','Error Setting Features extraction parameters'); 
%             fclose(obj);
%             return
%         end
%     else
%         set(handles.t_msg,'String','Error Setting Features extraction parameters'); 
%         fclose(obj);
%         return
%     end
    
    pause(0.5);
    
    featureTime = (tWs-oWs)/sF;
    maxCount = round((1/featureTime)/2);
    if maxCount < 1
        maxCount = 1;
    end
    refreshBarsCount = 0;
    
    % Start the features extraction
    fwrite(obj,'X','uint8');
    fwrite(obj,chIdxExtra,'uint8'); % keep compatibility of old GUI with new channels
    fwrite(obj,chIdxUpper,'uint8');
    fwrite(obj,chIdxLower,'uint8');
    fwrite(obj,nCh,'uint8');
    replay = char(fread(obj,1,'char'));
    if strcmp(replay,'X')
        set(handles.t_msg,'String','Features reception Start');
    else
        set(handles.t_msg,'String','Error Start'); 
        fclose(obj);
        return
    end
    drawnow;
    
    tic;
    for i = 1:samples
        % (4bytes X features X nCh channels)
        byteData = fread(obj,(nFeatures*nCh),'float32');                             
        features(i,:) = byteData; 
        % update the MVC level
        chCount = 1;
        for j = 1 : 16
            if chs(j)
                if byteData(chCount) > MVC(j)
                    MVC(j) = byteData(chCount);
                end
                chCount = chCount + 1;
            end
        end 
        refreshBarsCount = refreshBarsCount+1;
        % get the plot routines faster
        if refreshBarsCount == maxCount
            UpdateBars(byteData, handles);   
            refreshBarsCount = 0;
        end
    end
    disp(toc)
    
    % Stop the aquisition
    fwrite(obj,'T','char');
    % Close connection
    fclose(obj);
    
    set(handles.t_msg,'String','Features Received');
    save('features.mat','features');
    
    % Update the GUI
    for i = 1 : 16
        if chs(i)
            message = sprintf('%d', MVC(i));
            set(eval(strcat('handles.et_MVC',num2str(i))),'String',message);
            set(eval(strcat('handles.s_thresh',num2str(i))),'Max',MVC(i),'Min',0,'SliderStep',[MVC(i)/100 MVC(i)/100]);
        end
    end
    drawnow;
    
    if(checkNoiseLevel)
        chCount = 1;
        for i = 1 : 16      
            if chs(i)
                noiseLevel(i) = mean(features(:,chCount));
                set(eval(strcat('handles.s_thresh',num2str(i))),'Value',noiseLevel(i));
                newValue = get(eval(strcat('handles.s_thresh',num2str(i))),'Value');
                set(eval(strcat('handles.et_thresh',num2str(i))),'string',sprintf('%d', newValue));  
                chCount = chCount + 1;
            end
        end   
    end
    
    % find open hand channel, if it is already assigned 
    openHandChannel = 0;
    for i = 1 : 16
        if get(eval(strcat('handles.pm_selMov',num2str(i))),'Value')==2
            openHandChannel = i;
        end
    end
    if (openHandChannel~=0)
        % update plot for open hand channel recording
        recTime = samples*featureTime;
        axes(handles.ax_open)
        chIndex = find((find(chs)==openHandChannel)==1);
        plot(linspace(0,recTime,samples),features(:,chIndex))
        hold on
        handles.openLineMVC = plot(linspace(0,recTime,samples),ones(1,samples)*MVC(openHandChannel),'-r','LineWidth',2.5,'ButtonDownFcn', @(hObject,eventdata)GUI_SetDC('startDragOpenLineMVC_Fcn',hObject,eventdata,guidata(hObject)));
        handles.openLineThresh = plot(linspace(0,recTime,samples),ones(1,samples)*MVC(openHandChannel)/2,'-b','LineWidth',2.5,'ButtonDownFcn',@(hObject,eventdata)GUI_SetDC('startDragOpenLineThresh_Fcn',hObject,eventdata,guidata(hObject)));
        hold off
    end
    
    % find close hand channel, if it is already assigned 
    closeHandChannel = 0;
    for i = 1 : 16
        if get(eval(strcat('handles.pm_selMov',num2str(i))),'Value')==3
            closeHandChannel = i;
        end
    end
    if (closeHandChannel~=0)
        % update plot for close hand channel recording
        recTime = samples*featureTime;
        axes(handles.ax_close)
        chIndex = find((find(chs)==closeHandChannel)==1);
        plot(linspace(0,recTime,samples),features(:,chIndex))
        hold on
        handles.closeLineMVC = plot(linspace(0,recTime,samples),ones(1,samples)*MVC(closeHandChannel),'-r','LineWidth',2.5,'ButtonDownFcn', @(hObject,eventdata)GUI_SetDC('startDragCloseLineMVC_Fcn',hObject,eventdata,guidata(hObject)));
        handles.closeLineThresh = plot(linspace(0,recTime,samples),ones(1,samples)*MVC(closeHandChannel)/2,'-b','LineWidth',2.5,'ButtonDownFcn',@(hObject,eventdata)GUI_SetDC('startDragCloseLineThresh_Fcn',hObject,eventdata,guidata(hObject)));
        hold off
    end
    
    % find switch channel, if it is already assigned 
    switchChannel = 0;
    for i = 1 : 16
        if get(eval(strcat('handles.pm_selMov',num2str(i))),'Value')==4
            switchChannel = i;
        end
    end
    if (switchChannel~=0)
        % update plot for close hand channel recording
        recTime = samples*featureTime;
        axes(handles.ax_ramp)
        chIndex = find((find(chs)==switchChannel)==1);
        plot(linspace(0,recTime,samples),features(:,chIndex))
        hold on
        handles.switchLineMVC = plot(linspace(0,recTime,samples),ones(1,samples)*MVC(switchChannel),'-r','LineWidth',2.5,'ButtonDownFcn', @(hObject,eventdata)GUI_SetDC('startDragSwitchLineMVC_Fcn',hObject,eventdata,guidata(hObject)));
        handles.switchLineThresh = plot(linspace(0,recTime,samples),ones(1,samples)*MVC(switchChannel)/2,'-b','LineWidth',2.5,'ButtonDownFcn',@(hObject,eventdata)GUI_SetDC('startDragSwitchLineThresh_Fcn',hObject,eventdata,guidata(hObject)));
        hold off
    end
    
    % Update handles structure
    guidata(hObject, handles);
    
    
function startDragOpenLineMVC_Fcn(hObject, eventdata, handles)
        set(handles.figure1, 'WindowButtonMotionFcn', @(hObject,eventdata)GUI_SetDC('draggingOpenLineMVC_Fcn',hObject,eventdata,guidata(hObject))); 
    
function draggingOpenLineMVC_Fcn(hObject, eventdata, handles)
        global MVC;
        pt = get(handles.ax_open, 'CurrentPoint');
        set(handles.openLineMVC, 'YData', ones(1,length(get(handles.openLineThresh,'XData')))*pt(1,2)); 
        % find open hand channel
        openHandChannel = 0;
        for i = 1 : 16
            if get(eval(strcat('handles.pm_selMov',num2str(i))),'Value')==2
                openHandChannel = i;
            end
        end
        if (openHandChannel==0)
            errordlg('open hand channel must be assigned before proceeding!');
            return
        end
        % update parameters for that channel according to new position of
        % the line
        MVC(openHandChannel) = pt(1,2);
        set(eval(strcat('handles.et_MVC',num2str(openHandChannel))),'String',sprintf('%d', pt(1,2)));
        set(eval(strcat('handles.s_thresh',num2str(openHandChannel))),'min',0);
        set(eval(strcat('handles.s_thresh',num2str(openHandChannel))),'max',pt(1,2));
        
        
function startDragOpenLineThresh_Fcn(hObject, eventdata, handles)
        set(handles.figure1, 'WindowButtonMotionFcn', @(hObject,eventdata)GUI_SetDC('draggingOpenLineThresh_Fcn',hObject,eventdata,guidata(hObject))); 
    
function draggingOpenLineThresh_Fcn(hObject, eventdata, handles)
        pt = get(handles.ax_open, 'CurrentPoint');
        set(handles.openLineThresh, 'YData', ones(1,length(get(handles.openLineThresh,'XData')))*pt(1,2));
        % find open hand channel
        openHandChannel = 0;
        for i = 1 : 16
            if get(eval(strcat('handles.pm_selMov',num2str(i))),'Value')==2
                openHandChannel = i;
            end
        end
        if (openHandChannel==0)
            errordlg('open hand channel must be assigned before proceeding!');
            return
        end
        % update parameters for that channel according to new position of
        % the line
        set(eval(strcat('handles.et_thresh',num2str(openHandChannel))),'String',sprintf('%d', pt(1,2)));
        set(eval(strcat('handles.s_thresh',num2str(openHandChannel))),'Value',pt(1,2)); 
        
        
function startDragCloseLineMVC_Fcn(hObject, eventdata, handles)
        set(handles.figure1, 'WindowButtonMotionFcn', @(hObject,eventdata)GUI_SetDC('draggingCloseLineMVC_Fcn',hObject,eventdata,guidata(hObject))); 
    
function draggingCloseLineMVC_Fcn(hObject, eventdata, handles)
        global MVC;
        pt = get(handles.ax_close, 'CurrentPoint');
        set(handles.closeLineMVC, 'YData', ones(1,length(get(handles.closeLineThresh,'XData')))*pt(1,2)); 
        % find close hand channel
        closeHandChannel = 0;
        for i = 1 : 16
            if get(eval(strcat('handles.pm_selMov',num2str(i))),'Value')==3
                closeHandChannel = i;
            end
        end
        if (closeHandChannel==0)
            errordlg('close hand channel must be assigned before proceeding!');
            return
        end
        % update parameters for that channel according to new position of
        % the line
        MVC(closeHandChannel) = pt(1,2);
        set(eval(strcat('handles.et_MVC',num2str(closeHandChannel))),'String',sprintf('%d', pt(1,2)));
        set(eval(strcat('handles.s_thresh',num2str(closeHandChannel))),'min',0);
        set(eval(strcat('handles.s_thresh',num2str(closeHandChannel))),'max',pt(1,2));
        
function startDragCloseLineThresh_Fcn(hObject, eventdata, handles)
        set(handles.figure1, 'WindowButtonMotionFcn', @(hObject,eventdata)GUI_SetDC('draggingCloseLineThresh_Fcn',hObject,eventdata,guidata(hObject))); 
    
function draggingCloseLineThresh_Fcn(hObject, eventdata, handles)
        pt = get(handles.ax_close, 'CurrentPoint');
        set(handles.closeLineThresh, 'YData', ones(1,length(get(handles.closeLineThresh,'XData')))*pt(1,2));
        % find close hand channel
        closeHandChannel = 0;
        for i = 1 : 16
            if get(eval(strcat('handles.pm_selMov',num2str(i))),'Value')==3
                closeHandChannel = i;
            end
        end
        if (closeHandChannel==0)
            errordlg('close hand channel must be assigned before proceeding!');
            return
        end
        % update parameters for that channel according to new position of
        % the line
        set(eval(strcat('handles.et_thresh',num2str(closeHandChannel))),'String',sprintf('%d', pt(1,2)));
        set(eval(strcat('handles.s_thresh',num2str(closeHandChannel))),'Value',pt(1,2));        
        
        
function startDragSwitchLineMVC_Fcn(hObject, eventdata, handles)
        set(handles.figure1, 'WindowButtonMotionFcn', @(hObject,eventdata)GUI_SetDC('draggingSwitchLineMVC_Fcn',hObject,eventdata,guidata(hObject))); 
    
function draggingSwitchLineMVC_Fcn(hObject, eventdata, handles)
        global MVC;
        pt = get(handles.ax_ramp, 'CurrentPoint');
        set(handles.switchLineMVC, 'YData', ones(1,length(get(handles.switchLineThresh,'XData')))*pt(1,2)); 
        % find close hand channel
        switchChannel = 0;
        for i = 1 : 16
            if get(eval(strcat('handles.pm_selMov',num2str(i))),'Value')==4
                switchChannel = i;
            end
        end
        if (switchChannel==0)
            errordlg('switch channel must be assigned before proceeding!');
            return
        end
        % update parameters for that channel according to new position of
        % the line
        MVC(switchChannel) = pt(1,2);
        set(eval(strcat('handles.et_MVC',num2str(switchChannel))),'String',sprintf('%d', pt(1,2)));
        set(eval(strcat('handles.s_thresh',num2str(switchChannel))),'min',0);
        set(eval(strcat('handles.s_thresh',num2str(switchChannel))),'max',pt(1,2));
        
function startDragSwitchLineThresh_Fcn(hObject, eventdata, handles)
        set(handles.figure1, 'WindowButtonMotionFcn', @(hObject,eventdata)GUI_SetDC('draggingSwitchLineThresh_Fcn',hObject,eventdata,guidata(hObject))); 
    
function draggingSwitchLineThresh_Fcn(hObject, eventdata, handles)
        pt = get(handles.ax_ramp, 'CurrentPoint');
        set(handles.switchLineThresh, 'YData', ones(1,length(get(handles.switchLineThresh,'XData')))*pt(1,2));
        % find switch channel
        switchChannel = 0;
        for i = 1 : 16
            if get(eval(strcat('handles.pm_selMov',num2str(i))),'Value')==4
                switchChannel = i;
            end
        end
        if (switchChannel==0)
            errordlg('switch channel must be assigned before proceeding!');
            return
        end
        % update parameters for that channel according to new position of
        % the line
        set(eval(strcat('handles.et_thresh',num2str(switchChannel))),'String',sprintf('%d', pt(1,2)));
        set(eval(strcat('handles.s_thresh',num2str(switchChannel))),'Value',pt(1,2));   
        
        
function stopDragFcn(hObject, eventdata, handles)
        set(handles.figure1, 'WindowButtonMotionFcn', '');
    
                    
function UpdateBars(data, handles)    

    global MVC;
    global chs;
    
    chCount = 1;
    for j = 1 : 16
        if chs(j)
            set(eval(strcat('handles.p_',num2str(j))),'YLim',[0 MVC(j)]);
            set(handles.p_t(j),'YData', data(chCount));
            chCount = chCount + 1;
        end
    end 
    drawnow expose

    
% --------------------------------------------------------------------
function menu_ALCD_Callback(hObject, eventdata, handles)
% hObject    handle to menu_ALCD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_connect_Callback(hObject, eventdata, handles)
% hObject    handle to menu_connect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Ask for connection settings
    prompt = {'Enter COM Port:','Enter baudrate:'};
    dlg_title = 'Connect to ALC-D';
    num_lines = 1;
    def = {'5','460800'};
    answer = inputdlg(prompt,dlg_title,num_lines,def);
    if size(answer,1) ~= 2
        return
    end
    ComPortName = num2str(char(answer(1)));
    baud = str2num(char(answer(2)));

    %WiFi = get(handles.cb_WiFi,'Value');
    WiFi = 0;
    if ispc
        ComPortName = strcat('COM',ComPortName);
    end
    set(handles.t_msg,'String','Testing connection...');   
    if isfield(handles,'obj')
        obj = handles.obj;
        fclose(obj);
    else
         if WiFi
            obj = tcpip('192.168.100.10',65100,'NetworkRole','client');        % WIICOM
         else
            obj = serial (ComPortName, 'baudrate', baud, 'databits', 8, 'byteorder', 'bigEndian');
         end
    end
    % Open connection
    fclose(obj);
    fopen(obj);
    fwrite(obj,'A','char');
    fwrite(obj,'C','char');
    replay = char(fread(obj,1,'char'));
    if strcmp(replay,'C')
        set(handles.t_msg,'String','Connection established');
    else
        set(handles.t_msg,'String','Error, device is not responding or COM port is changed!');        
    end
    fclose(obj);
    handles.obj = obj;
    guidata(hObject,handles);


% --- Executes on selection change in pm_serialport.
function pm_serialport_Callback(hObject, eventdata, handles)
% hObject    handle to pm_serialport (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_serialport contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_serialport


% --- Executes during object creation, after setting all properties.
function pm_serialport_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_serialport (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function et_time_Callback(hObject, eventdata, handles)
% hObject    handle to et_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_time as text
%        str2double(get(hObject,'String')) returns contents of et_time as a double


% --- Executes during object creation, after setting all properties.
function et_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function s_thresh1_Callback(hObject, eventdata, handles)
% hObject    handle to s_thresh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% if get(handles.et_thresh1,'Max') == 1
%    errordlg('no info loaded: run real time!');
%    return
% end
newValue = get(hObject,'Value');
newValue = sprintf('%d', newValue);
set(handles.et_thresh1,'string',newValue);


% --- Executes during object creation, after setting all properties.
function s_thresh1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_thresh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function s_thresh4_Callback(hObject, eventdata, handles)
% hObject    handle to s_thresh4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
newValue = get(hObject,'Value');
newValue = sprintf('%d', newValue);
set(handles.et_thresh4,'string',newValue);

% --- Executes during object creation, after setting all properties.
function s_thresh4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_thresh4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function s_thresh3_Callback(hObject, eventdata, handles)
% hObject    handle to s_thresh3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
newValue = get(hObject,'Value');
newValue = sprintf('%d', newValue);
set(handles.et_thresh3,'string',newValue);

% --- Executes during object creation, after setting all properties.
function s_thresh3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_thresh3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function s_thresh2_Callback(hObject, eventdata, handles)
% hObject    handle to s_thresh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
newValue = get(hObject,'Value');
newValue = sprintf('%d', newValue);
set(handles.et_thresh2,'string',newValue);

% --- Executes during object creation, after setting all properties.
function s_thresh2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_thresh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function s_thresh8_Callback(hObject, eventdata, handles)
% hObject    handle to s_thresh8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
newValue = get(hObject,'Value');
newValue = sprintf('%d', newValue);
set(handles.et_thresh8,'string',newValue);

% --- Executes during object creation, after setting all properties.
function s_thresh8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_thresh8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function s_thresh7_Callback(hObject, eventdata, handles)
% hObject    handle to s_thresh7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
newValue = get(hObject,'Value');
newValue = sprintf('%d', newValue);
set(handles.et_thresh7,'string',newValue);

% --- Executes during object creation, after setting all properties.
function s_thresh7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_thresh7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function s_thresh5_Callback(hObject, eventdata, handles)
% hObject    handle to s_thresh5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
newValue = get(hObject,'Value');
newValue = sprintf('%d', newValue);
set(handles.et_thresh5,'string',newValue);

% --- Executes during object creation, after setting all properties.
function s_thresh5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_thresh5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function s_thresh6_Callback(hObject, eventdata, handles)
% hObject    handle to s_thresh6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
newValue = get(hObject,'Value');
newValue = sprintf('%d', newValue);
set(handles.et_thresh6,'string',newValue);

% --- Executes during object creation, after setting all properties.
function s_thresh6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_thresh6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --------------------------------------------------------------------
function menu_read_Callback(hObject, eventdata, handles)
% hObject    handle to menu_read (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Get connection object
    if isfield(handles,'obj')
        obj = handles.obj;
    else
        set(handles.t_msg,'String','No connection obj found');   
        return;
    end
    % Open the connection
    fopen(obj);

    % Ask for control settings
    fwrite(obj,'s','char');
    replay = char(fread(obj,1,'char'));
    if strcmp(replay,'s')
        openHand.active = fread(obj,1,'char');
        openHand.MOVindex = 1;
        openHand.PWMoutput = fread(obj,1,'uint32');
        openHand.CHinput = fread(obj,1,'char');
        openHand.motorThresh = fread(obj,1,'float');
        openHand.MVClevel = fread(obj,1,'float');
        closeHand.active = fread(obj,1,'char');
        closeHand.MOVindex = 2;
        closeHand.PWMoutput = fread(obj,1,'uint32');
        closeHand.CHinput = fread(obj,1,'char');
        closeHand.motorThresh = fread(obj,1,'float');
        closeHand.MVClevel = fread(obj,1,'float');
        switch1.active = fread(obj,1,'char');
        switch1.MOVindex = 3;
        switch1.PWMoutput = fread(obj,1,'uint32');
        switch1.CHinput = fread(obj,1,'char');
        switch1.motorThresh = fread(obj,1,'float');
        switch1.MVClevel = fread(obj,1,'float');  
        pronation.active = fread(obj,1,'char');
        pronation.MOVindex = 4;
        pronation.PWMoutput = fread(obj,1,'uint32');
        pronation.CHinput = fread(obj,1,'char');
        pronation.motorThresh = fread(obj,1,'float');
        pronation.MVClevel = fread(obj,1,'float');
        supination.active = fread(obj,1,'char');
        supination.MOVindex = 5;
        supination.PWMoutput = fread(obj,1,'uint32');
        supination.CHinput = fread(obj,1,'char');
        supination.motorThresh = fread(obj,1,'float');
        supination.MVClevel = fread(obj,1,'float');   
        cocontraction.active = fread(obj,1,'char');
        cocontraction.MOVindex = 6;
        cocontraction.PWMoutput = fread(obj,1,'uint32');
        cocontraction.thresh1 = fread(obj,1,'float');
        cocontraction.thresh2 = fread(obj,1,'float');  
        
        replay = char(fread(obj,1,'char'));
        if strcmp(replay,'s')
            disp(obj)
            movs.openHand = openHand;
            movs.closeHand = closeHand;
            movs.pronation = pronation;
            movs.supination = supination;
            movs.switch1 = switch1;
            movs.cocontraction = cocontraction;
            save('SETTINGS.mat','movs');  
            set(handles.t_msg,'String','Control settings read from ALC-D and saved into SETTINGS.mat file');
        else
            set(handles.t_msg,'String','Error Reading Control settings'); 
            fclose(obj);
            return
        end
    else
        set(handles.t_msg,'String','Error Reading Control settings'); 
        fclose(obj);
        return
    end

    fclose(obj);
    
    % Check if a double function was set on the same channel
    if (movs.openHand.CHinput == movs.closeHand.CHinput) || (movs.openHand.CHinput == movs.pronation.CHinput) ...
        || (movs.openHand.CHinput == movs.supination.CHinput) || (movs.openHand.CHinput == movs.switch1.CHinput)
        set(handles.t_msg,'String','More than one function is set on the same channel, please check SETTINGS file'); 
    end
    
    % Check if some of the extrachannels is in use
    if (movs.openHand.CHinput > 15) || (movs.openHand.CHinput > 15) ...
        || (movs.pronation.CHinput > 15) || (movs.supination.CHinput > 15) ...
        || (movs.switch1.CHinput > 15)
        set(handles.t_msg,'String','Extra channels are set, please use the 24 channels GUI'); 
    end
    
    % Update the GUI with these information
    for i = 1 : 16
        set(eval(strcat('handles.cb_',num2str(i))),'Value',0);
    end
    mvc = zeros(16,1);
    select = ones(16,1);
    if(movs.openHand.active)
        mvc(movs.openHand.CHinput+1) = movs.openHand.MVClevel;
        thresh(movs.openHand.CHinput+1) = movs.openHand.motorThresh;
        select(movs.openHand.CHinput+1) = 2;
        set(eval(strcat('handles.cb_',num2str(movs.openHand.CHinput+1))),'Value',1);
    end
    if(movs.closeHand.active)
        mvc(movs.closeHand.CHinput+1) = movs.closeHand.MVClevel;
        thresh(movs.closeHand.CHinput+1) = movs.closeHand.motorThresh;
        select(movs.closeHand.CHinput+1) = 3;
        set(eval(strcat('handles.cb_',num2str(movs.closeHand.CHinput+1))),'Value',1);
    end
    if(movs.switch1.active)
        mvc(movs.switch1.CHinput+1) = movs.switch1.MVClevel;
        thresh(movs.switch1.CHinput+1) = movs.switch1.motorThresh;
        select(movs.switch1.CHinput+1) = 4;
        set(eval(strcat('handles.cb_',num2str(movs.switch1.CHinput+1))),'Value',1);
    end
    if(movs.pronation.active)
        mvc(movs.pronation.CHinput+1) = movs.pronation.MVClevel;
        thresh(movs.pronation.CHinput+1) = movs.pronation.motorThresh;
        select(movs.pronation.CHinput+1) = 5;
        set(eval(strcat('handles.cb_',num2str(movs.pronation.CHinput+1))),'Value',1);
    end
    if(movs.supination.active)
        mvc(movs.supination.CHinput+1) = movs.supination.MVClevel;
        thresh(movs.supination.CHinput+1) = movs.supination.motorThresh;
        select(movs.supination.CHinput+1) = 6;
        set(eval(strcat('handles.cb_',num2str(movs.supination.CHinput+1))),'Value',1);
    end
    for j = 1 : 16
        set(handles.p_t(j),'YData', 0);
        if(mvc(j)~= 0 && select(j) ~= 1)
            set(eval(strcat('handles.et_MVC',num2str(j))),'String',sprintf('%d', mvc(j)));
            set(eval(strcat('handles.p_',num2str(j))),'YLim',[0 mvc(j)]);
            set(eval(strcat('handles.et_thresh',num2str(j))),'string',sprintf('%d', thresh(j)));
            set(eval(strcat('handles.s_thresh',num2str(j))),'Max',mvc(j),'Min',0);
            set(eval(strcat('handles.s_thresh',num2str(j))),'Value',thresh(j));
            set(eval(strcat('handles.pm_selMov',num2str(j))),'Value',select(j));
        else
            set(eval(strcat('handles.et_MVC',num2str(j))),'String','');
            set(eval(strcat('handles.et_thresh',num2str(j))),'String','');
            set(eval(strcat('handles.s_thresh',num2str(j))),'Value',0);
            set(eval(strcat('handles.pm_selMov',num2str(j))),'Value',1);
        end
    end  
    if(movs.cocontraction.active)
        set(handles.cb_cocEnable,'Value',1);
    else
        set(handles.cb_cocEnable,'Value',0);
    end  


% --------------------------------------------------------------------
function menu_write_Callback(hObject, eventdata, handles)
% hObject    handle to menu_write (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Selected channels
    chs = [];
    for i = 1 : 16
        chs(i) = get(eval(strcat('handles.cb_',num2str(i))),'Value');
    end
    chIdxExtra = 0;
    chIdxUpper = bitshift(sum(bitset(0,find(chs==1))),-8);
    chIdxLower = bitand(sum(bitset(0,find(chs==1))),255);
    nCh = size(find(chs==1),2);
    
    % Prepare information to send
    cocontractEnable = get(handles.cb_cocEnable,'Value');
    
    nMovements = 0;
    for i = 1 : 16
        tempMov = get(eval(strcat('handles.pm_selMov',num2str(i))),'Value');
        if tempMov ~= 1 % different from 'Select Movement' string
            nMovements = nMovements + 1;
            selMov(nMovements).active = 1;
            selMov(nMovements).MOVindex = tempMov-1;
            chIndex = i;
            selMov(nMovements).CHinput = chIndex-1;
            temp = get(eval(strcat('handles.et_thresh',num2str(i))),'String'); % Insert control to 0 value!!!!!
            if strcmp(temp,'')
                errordlg('One or more threshold values were not selected. A value of zero will be used');
                selMov(nMovements).motorThresh = 0;
            else
                selMov(nMovements).motorThresh = str2num(temp);
            end
            selMov(nMovements).MVClevel = str2num(get(eval(strcat('handles.et_MVC',num2str(i))),'String'));
        end   
    end
    if cocontractEnable
        nMovements = nMovements + 1;
        selMov(nMovements).active = 1;
        selMov(nMovements).MOVindex = 6;
        selMov(nMovements).thresh1 = 1.5; % hardcoded here, to be fixed!
        selMov(nMovements).thresh2 = 1.5; % hardcoded here, to be fixed!
    end

    doublFunctCh = get(handles.pm_selExtraCh,'Value')-1;
    if doublFunctCh ~= 0
        % if we want to set a double function on the same channel
        tempMov = get(handles.pm_selExtraMov,'Value');
        if tempMov ~= 1 % different from 'Select Movement' string
            nMovements = nMovements + 1;
            selMov(nMovements).active = 1;
            selMov(nMovements).MOVindex = tempMov-1;
            selMov(nMovements).CHinput = doublFunctCh-1; % channel index is from 0 to 7
            temp = get(handles.et_extraThresh,'String'); % Insert control to 0 value!!!!!
            if strcmp(temp,'')
                errordlg('One or more threshold values were not selected. A value of zero will be used');
                selMov(nMovements).motorThresh = 0;
            else
                selMov(nMovements).motorThresh = str2num(temp);
            end
            selMov(nMovements).MVClevel = str2num(get(handles.et_extraMVC,'String'));
        end
    end
    
    % Get connection object
    if isfield(handles,'obj')
        obj = handles.obj;
    else
        set(handles.t_msg,'String','No connection obj found');   
        return;
    end
    % Open the connection
    fopen(obj);

    % Write 
    fwrite(obj,'w','char');
    replay = char(fread(obj,1,'char'));
    if strcmp(replay,'w')
        fwrite(obj,nMovements,'char');
        for i = 1:nMovements
            fwrite(obj,selMov(i).active,'char');
            fwrite(obj,selMov(i).MOVindex,'char');
            fwrite(obj,selMov(i).CHinput,'char');
            fwrite(obj,selMov(i).motorThresh,'float');
            fwrite(obj,selMov(i).MVClevel,'float');
        end
        replay = char(fread(obj,1,'char'));
        if strcmp(replay,'w')
            set(handles.t_msg,'String','Control settings correctly sent to ALC-D');
        else
            set(handles.t_msg,'String','Error sending Control settings'); 
            fclose(obj);
            return
        end
    else
        set(handles.t_msg,'String','Error sending Control settings'); 
        fclose(obj);
        return
    end

    fclose(obj);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% % Get connection object
% if isfield(handles,'obj')
%     obj = handles.obj;
%     % Close and delete connection
%     if strcmp(obj.status,'open')
%         fclose(obj);
%     end
%     delete(obj);
% end

% Hint: delete(hObject) closes the figure
delete(hObject);



function et_MVC9_Callback(hObject, eventdata, handles)
% hObject    handle to et_MVC9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_MVC9 as text
%        str2double(get(hObject,'String')) returns contents of et_MVC9 as a double


% --- Executes during object creation, after setting all properties.
function et_MVC9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_MVC9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_selMov9.
function pm_selMov9_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selMov9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selMov9 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selMov9


% --- Executes during object creation, after setting all properties.
function pm_selMov9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selMov9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_thresh9_Callback(hObject, eventdata, handles)
% hObject    handle to et_thresh9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_thresh9 as text
%        str2double(get(hObject,'String')) returns contents of et_thresh9 as a double


% --- Executes during object creation, after setting all properties.
function et_thresh9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_thresh9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function s_thresh9_Callback(hObject, eventdata, handles)
% hObject    handle to s_thresh9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
newValue = get(hObject,'Value');
newValue = sprintf('%d', newValue);
set(handles.et_thresh9,'string',newValue);


% --- Executes during object creation, after setting all properties.
function s_thresh9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_thresh9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in cb_cocEnable.
function cb_cocEnable_Callback(hObject, eventdata, handles)
% hObject    handle to cb_cocEnable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_cocEnable


% --- Executes on button press in cb_1.
function cb_1_Callback(hObject, eventdata, handles)
% hObject    handle to cb_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_1


% --- Executes on button press in cb_2.
function cb_2_Callback(hObject, eventdata, handles)
% hObject    handle to cb_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_2


% --- Executes on button press in cb_3.
function cb_3_Callback(hObject, eventdata, handles)
% hObject    handle to cb_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_3


% --- Executes on button press in cb_4.
function cb_4_Callback(hObject, eventdata, handles)
% hObject    handle to cb_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_4


% --- Executes on button press in cb_5.
function cb_5_Callback(hObject, eventdata, handles)
% hObject    handle to cb_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_5


% --- Executes on button press in cb_6.
function cb_6_Callback(hObject, eventdata, handles)
% hObject    handle to cb_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_6


% --- Executes on button press in cb_7.
function cb_7_Callback(hObject, eventdata, handles)
% hObject    handle to cb_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_7


% --- Executes on button press in cb_8.
function cb_8_Callback(hObject, eventdata, handles)
% hObject    handle to cb_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_8


% --------------------------------------------------------------------
function menu_load_Callback(hObject, eventdata, handles)
% hObject    handle to menu_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Browse and load a SETTINGS file
    [file, path] = uigetfile({'*.mat'});
    if ~isequal(file, 0)
        [pathstr,name,ext] = fileparts(file);
        if(strcmp(ext,'.mat'))
            load([path,file]);
            if (~exist('movs','var'))   
                disp('Not a valid Settings file');
                errordlg('Not a valid Settings file','Error');
                return;   
            end
        else
            disp('Not a valid Settings file');
            errordlg('Not a valid Settings file','Error');
            return; 
        end
    end

    % Update the GUI with these information
    mvc = zeros(16,1);
    select = ones(16,1);
    if(movs.openHand.active)
        mvc(movs.openHand.CHinput+1) = movs.openHand.MVClevel;
        thresh(movs.openHand.CHinput+1) = movs.openHand.motorThresh;
        select(movs.openHand.CHinput+1) = 2;
    end
    if(movs.closeHand.active)
        mvc(movs.closeHand.CHinput+1) = movs.closeHand.MVClevel;
        thresh(movs.closeHand.CHinput+1) = movs.closeHand.motorThresh;
        select(movs.closeHand.CHinput+1) = 3;
    end
    if(movs.pronation.active)
        mvc(movs.pronation.CHinput+1) = movs.pronation.MVClevel;
        thresh(movs.pronation.CHinput+1) = movs.pronation.motorThresh;
        select(movs.pronation.CHinput+1) = 4;
    end
    if(movs.supination.active)
        mvc(movs.supination.CHinput+1) = movs.supination.MVClevel;
        thresh(movs.supination.CHinput+1) = movs.supination.motorThresh;
        select(movs.supination.CHinput+1) = 5;
    end
    if(exist('movs.switch1','var'))
        if(movs.switch1.active)
            mvc(movs.switch1.CHinput+1) = movs.switch1.MVClevel;
            thresh(movs.switch1.CHinput+1) = movs.switch1.motorThresh;
            select(movs.switch1.CHinput+1) = 6;
        end
    end
    for j = 1 : 16
        set(handles.p_t(j),'YData', 0);
        if(mvc(j)~= 0 && select(j) ~= 1)
            set(eval(strcat('handles.et_MVC',num2str(j))),'String',sprintf('%d', mvc(j)));
            set(eval(strcat('handles.p_',num2str(j))),'YLim',[0 mvc(j)]);
            set(eval(strcat('handles.et_thresh',num2str(j))),'string',sprintf('%d', thresh(j)));
            set(eval(strcat('handles.s_thresh',num2str(j))),'Max',mvc(j),'Min',0);
            set(eval(strcat('handles.s_thresh',num2str(j))),'Value',thresh(j));
            set(eval(strcat('handles.pm_selMov',num2str(j))),'Value',select(j));
        else
            set(eval(strcat('handles.et_MVC',num2str(j))),'String','');
            set(eval(strcat('handles.et_thresh',num2str(j))),'String','');
            set(eval(strcat('handles.s_thresh',num2str(j))),'Value',0);
            set(eval(strcat('handles.pm_selMov',num2str(j))),'Value',1);  
        end
    end  
    if(isfield(movs,'cocontraction'))
        if(movs.cocontraction.active)
            set(handles.cb_cocEnable,'Value',1);
        else
            set(handles.cb_cocEnable,'Value',0);
        end
    else
        set(handles.cb_cocEnable,'Value',0);
    end


% --------------------------------------------------------------------
function menu_loadRampRec_Callback(hObject, eventdata, handles)
% hObject    handle to menu_loadRampRec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Browse and load a ramp recording session file
    [file, path] = uigetfile({'*.mat'});
    if ~isequal(file, 0)
        [pathstr,name,ext] = fileparts(file);
        if(strcmp(ext,'.mat'))
            load([path,file]);
            if (~exist('recSession','var') || ~isfield(recSession,'ramp'))   
                disp('Not a valid Settings file');
                errordlg('Not a valid Settings file','Error');
                return;   
            end
        else
            disp('Not a valid Settings file');
            errordlg('Not a valid Settings file','Error');
            return; 
        end
    end
    
    % add processing to auto calibrate the control accordingly to the
    % signal given as input
    % It should be able to:
    % - suggest best channel for each movement
    % - suggest thresholds for activation
    % - update MVC and rescale strength bar


% --- Executes on button press in cb_reset.
function cb_reset_Callback(hObject, eventdata, handles)
% hObject    handle to cb_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_reset



function et_extraMVC_Callback(hObject, eventdata, handles)
% hObject    handle to et_extraMVC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_extraMVC as text
%        str2double(get(hObject,'String')) returns contents of et_extraMVC as a double


% --- Executes during object creation, after setting all properties.
function et_extraMVC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_extraMVC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_selExtraMov.
function pm_selExtraMov_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selExtraMov (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selExtraMov contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selExtraMov


% --- Executes during object creation, after setting all properties.
function pm_selExtraMov_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selExtraMov (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_extraThresh_Callback(hObject, eventdata, handles)
% hObject    handle to et_extraThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_extraThresh as text
%        str2double(get(hObject,'String')) returns contents of et_extraThresh as a double


% --- Executes during object creation, after setting all properties.
function et_extraThresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_extraThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider10_Callback(hObject, eventdata, handles)
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in pm_selExtraCh.
function pm_selExtraCh_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selExtraCh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selExtraCh contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selExtraCh

    % the info of the interested channel are copied
    selection = get(handles.pm_selExtraCh,'Value')-1;
    if selection == 0
        set(handles.et_extraMVC,'String','');
        set(handles.et_extraThresh,'String','');
    else
        set(handles.et_extraMVC,'String',(get(eval(strcat('handles.et_MVC',num2str(selection))),'String')));
        set(handles.et_extraThresh,'String',(get(eval(strcat('handles.et_thresh',num2str(selection))),'String')));
    end


% --- Executes during object creation, after setting all properties.
function pm_selExtraCh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selExtraCh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cb_noiseLevel.
function cb_noiseLevel_Callback(hObject, eventdata, handles)
% hObject    handle to cb_noiseLevel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_noiseLevel


% --------------------------------------------------------------------
function menu_calibrations_Callback(hObject, eventdata, handles)
% hObject    handle to menu_calibrations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
% Thresholds Calibration tab -> Channel range check
% Contains ERRORS
function menu_calibration_Callback(hObject, eventdata, handles)
% hObject    handle to menu_calibration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    global MVC;
    global chs;
    
    % Selected channels
    chs = [];
    
    % ERROR: field cb_ doesn't exist in handles
    for i = 1 : 16
        chs(i) = get(eval(strcat('handles.cb_',num2str(i))),'Value');
    end
    
    
    
    
    chIdxExtra = 0;
    chIdxUpper = bitshift(sum(bitset(0,find(chs==1))),-8);
    chIdxLower = bitand(sum(bitset(0,find(chs==1))),255);
    nCh = size(find(chs==1),2);
      
    resetValues = get(handles.cb_reset,'Value');
    if resetValues 
        for i = 1 : 16
            MVC(i) = 0;
            set(eval(strcat('handles.et_MVC',num2str(i))),'String','');
            set(eval(strcat('handles.et_thresh',num2str(i))),'String','');
            set(eval(strcat('handles.s_thresh',num2str(i))),'Value',0);
        end
    end
   
    % Initialization of progress bar
    set(handles.p_1,'YLimMode','manual');
    set(handles.p_2,'YLimMode','manual');
    
    % recover tWs and oWs info from GUI father (if it exists)
    if isfield(handles,'sF')
        sF = handles.sF;
    else
        sF = 1000;
    end
    if isfield(handles,'tWs')
        tWs = handles.tWs;
    else
        tWs = 0.05*sF;
    end
    if isfield(handles,'oWs')
        oWs = handles.oWs;
    else   
        oWs = sF*0.025;
    end
     
    % Get connection object
    if isfield(handles,'obj')
        obj = handles.obj;
    else
        set(handles.t_msg,'String','No connection obj found');   
        return;
    end  
    cT = 5;
    tW = tWs/sF;
    oW = oWs/sF;
    samples = round(cT/(tW-oW));
    
    % Set up receiving buffer
    obj.InputBufferSize = 4*16*samples*5;
    % Open the connection
    fopen(obj);
    % Read available data and discard it
    if obj.BytesAvailable > 0
        fread(obj,obj.BytesAvailable,'uint8');    % Read the samples        
    end  
 
    % Set the parameters for features extraction
    FeaturesEnables(1) = 1;
    FeaturesEnables(2) = 0;
    FeaturesEnables(3) = 0;
    FeaturesEnables(4) = 0;
    FeaturesEnables(5) = 0;
    nFeatures = sum(FeaturesEnables(:));
%     fwrite(obj,'f','char');
%     replay = char(fread(obj,1,'char'));
%     if strcmp(replay,'f')
%         fwrite(obj,tWs,'float');
%         fwrite(obj,oWs,'float');
%         fwrite(obj,nFeatures,'char');
%         for i = 1:size(FeaturesEnables,2)
%             fwrite(obj,FeaturesEnables(i),'char');
%         end
%         replay = char(fread(obj,1,'char'));
%         if strcmp(replay,'f');
%             set(handles.t_msg,'String','Features extraction parameters set');
%         else
%             set(handles.t_msg,'String','Error Setting Features extraction parameters'); 
%             fclose(obj);
%             return
%         end
%     else
%         set(handles.t_msg,'String','Error Setting Features extraction parameters'); 
%         fclose(obj);
%         return
%     end
    
    % Threshold Calibration start
    set(handles.t_msg,'String','Threshold Calibration start');
    pause(2)
    % rest recording
    set(handles.t_msg,'String','Prepare to rest');
    pause(2)
    set(handles.t_msg,'String','Prepare to rest......3');
    pause(1)
    set(handles.t_msg,'String','Prepare to rest......2');
    pause(1)
    set(handles.t_msg,'String','Prepare to rest......1');
    pause(1)
    set(handles.t_msg,'String','Relax, avoid any muscle contraction');
    % Read available data and discard it
    if obj.BytesAvailable > 0
        fread(obj,obj.BytesAvailable,'uint8');      
    end 
    % Start the features extraction
    fwrite(obj,'X','uint8');
    fwrite(obj,chIdxExtra,'uint8'); % keep compatibility of old GUI with new channels
    fwrite(obj,chIdxUpper,'uint8');
    fwrite(obj,chIdxLower,'uint8');
    fwrite(obj,nCh,'uint8');
    replay = char(fread(obj,1,'char'));
    if strcmp(replay,'X')
        set(handles.t_msg,'String','Features reception Start');
    else
        set(handles.t_msg,'String','Error Start'); 
        fclose(obj);
        return
    end
    drawnow;
    % throw away the first samples
    byteData = fread(obj,(nFeatures*nCh),'float32');
    byteData = fread(obj,(nFeatures*nCh),'float32');
    byteData = fread(obj,(nFeatures*nCh),'float32');    
    featureTime = (tWs-oWs)/sF;
    maxCount = round((1/featureTime)/2);
    if maxCount < 1
        maxCount = 1;
    end
    refreshBarsCount = 0;
    for i = 1:samples
        % (4bytes X features X nCh channels)
        byteData = fread(obj,(nFeatures*nCh),'float32');                             
        featuresNoise(i,:) = byteData; 
        % update the MVC level
        for j = 1 : nCh
            if byteData(j) > MVC(j)
                MVC(j) = byteData(j);
            end
        end 
        refreshBarsCount = refreshBarsCount+1;
        % get the plot routines faster
        if refreshBarsCount == maxCount
            UpdateBars(byteData, handles);   
            refreshBarsCount = 0;
        end
    end
    % Stop the aquisition
    fwrite(obj,'T','char');
    set(handles.t_msg,'String','Rest state Recorded');
    % Process noise level
    chCount = 1;
    for i = 1 : 16
        if chs(i) 
            noiseLevel(i) = mean(featuresNoise(:,chCount));
            set(eval(strcat('handles.s_thresh',num2str(i))),'Value',noiseLevel(i));
            newValue = get(eval(strcat('handles.s_thresh',num2str(i))),'Value');
            set(eval(strcat('handles.et_thresh',num2str(i))),'string',sprintf('%d', newValue));
            chCount = chCount + 1;
        end
    end
    % Update the GUI
    for i = 1 : 16
        if chs(i) 
            message = sprintf('%d', MVC(i));
            set(eval(strcat('handles.et_MVC',num2str(i))),'String',message);
            set(eval(strcat('handles.s_thresh',num2str(i))),'Max',MVC(i),'Min',0,'SliderStep',[MVC(i)/100 MVC(i)/100]);
        end
    end
    drawnow;
    
    % open hand recording
    set(handles.t_msg,'String','Prepare to open the hand at the minimum contraction');
    pause(3)
    set(handles.t_msg,'String','Prepare to open the hand at the minimum contraction.....3');
    pause(1)
    set(handles.t_msg,'String','Prepare to open the hand at the minimum contraction.....2');
    pause(1)
    set(handles.t_msg,'String','Prepare to open the hand at the minimum contraction.....1');
    pause(1)
    set(handles.t_msg,'String','Open the hand at the minimum contraction');
    % Read available data and discard it
    if obj.BytesAvailable > 0
        fread(obj,obj.BytesAvailable,'uint8');      
    end  
    % Start the features extraction
    fwrite(obj,'X','uint8');
    fwrite(obj,chIdxExtra,'uint8'); % keep compatibility of old GUI with new channels
    fwrite(obj,chIdxUpper,'uint8');
    fwrite(obj,chIdxLower,'uint8');
    fwrite(obj,nCh,'uint8');
    replay = char(fread(obj,1,'char'));
    if strcmp(replay,'X')
        set(handles.t_msg,'String','Features reception Start');
    else
        set(handles.t_msg,'String','Error Start'); 
        fclose(obj);
        return
    end
    drawnow;  
    % throw away the first samples
    byteData = fread(obj,(nFeatures*nCh),'float32');
    byteData = fread(obj,(nFeatures*nCh),'float32');
    byteData = fread(obj,(nFeatures*nCh),'float32');    
    featureTime = (tWs-oWs)/sF;
    maxCount = round((1/featureTime)/2);
    if maxCount < 1
        maxCount = 1;
    end
    refreshBarsCount = 0;
    for i = 1:samples
        % (4bytes X features X nCh channels)
        byteData = fread(obj,(nFeatures*nCh),'float32');                             
        featuresOpen(i,:) = byteData; 
        % update the MVC level
        chCount = 1;
        for j = 1 : 16
            if chs(j)
                if byteData(chCount) > MVC(j)
                    MVC(j) = byteData(chCount);
                end
                chCount = chCount + 1;
            end
        end
        refreshBarsCount = refreshBarsCount+1;
        % get the plot routines faster
        if refreshBarsCount == maxCount
            UpdateBars(byteData, handles);   
            refreshBarsCount = 0;
        end
    end
    % Stop the aquisition
    fwrite(obj,'T','char');
    set(handles.t_msg,'String','Open Hand Recorded');
    % Process open hand level and update GUI for the interested channel
    chCount = 1;
    for i = 1 : 16      
        if chs(i)
            openHand(i) = mean(featuresOpen(:,chCount));
            if get(eval(strcat('handles.pm_selMov',num2str(i))),'Value')==2
                set(eval(strcat('handles.s_thresh',num2str(i))),'Value',openHand(i));
                newValue = get(eval(strcat('handles.s_thresh',num2str(i))),'Value');
                set(eval(strcat('handles.et_thresh',num2str(i))),'string',sprintf('%d', newValue));
            end
            chCount = chCount + 1;
        end
    end
    % Update the GUI
    for i = 1 : 16
        if chs(i) 
            message = sprintf('%d', MVC(i));
            set(eval(strcat('handles.et_MVC',num2str(i))),'String',message);
            set(eval(strcat('handles.s_thresh',num2str(i))),'Max',MVC(i),'Min',0,'SliderStep',[MVC(i)/100 MVC(i)/100]);
        end
    end
    drawnow;
    
    % close hand recording
    set(handles.t_msg,'String','Prepare to close the hand at the minimum contraction');
    pause(3)
    set(handles.t_msg,'String','Prepare to close the hand at the minimum contraction.....3');
    pause(1)
    set(handles.t_msg,'String','Prepare to close the hand at the minimum contraction.....2');
    pause(1)
    set(handles.t_msg,'String','Prepare to close the hand at the minimum contraction.....1');
    pause(1)
    set(handles.t_msg,'String','Close the hand at the minimum contraction');
    % Read available data and discard it
    if obj.BytesAvailable > 0
        fread(obj,obj.BytesAvailable,'uint8');      
    end 
    % Start the features extraction
    fwrite(obj,'X','uint8');
    fwrite(obj,chIdxExtra,'uint8'); % keep compatibility of old GUI with new channels
    fwrite(obj,chIdxUpper,'uint8');
    fwrite(obj,chIdxLower,'uint8');
    fwrite(obj,nCh,'uint8');
    replay = char(fread(obj,1,'char'));
    if strcmp(replay,'X')
        set(handles.t_msg,'String','Features reception Start');
    else
        set(handles.t_msg,'String','Error Start'); 
        fclose(obj);
        return
    end
    drawnow; 
    % throw away the first samples
    byteData = fread(obj,(nFeatures*nCh),'float32');
    byteData = fread(obj,(nFeatures*nCh),'float32');
    byteData = fread(obj,(nFeatures*nCh),'float32');    
    featureTime = (tWs-oWs)/sF;
    maxCount = round((1/featureTime)/2);
    if maxCount < 1
        maxCount = 1;
    end
    refreshBarsCount = 0;
    for i = 1:samples
        % (4bytes X features X nCh channels)
        byteData = fread(obj,(nFeatures*nCh),'float32');                             
        featuresClose(i,:) = byteData; 
        % update the MVC level
        chCount = 1;
        for j = 1 : 16
            if chs(j)
                if byteData(chCount) > MVC(j)
                    MVC(j) = byteData(chCount);
                end
                chCount = chCount + 1;
            end
        end
        refreshBarsCount = refreshBarsCount+1;
        % get the plot routines faster
        if refreshBarsCount == maxCount
            UpdateBars(byteData, handles);   
            refreshBarsCount = 0;
        end
    end
    % Stop the aquisition
    fwrite(obj,'T','char');
    % Close connection
    fclose(obj);
    set(handles.t_msg,'String','Close Hand Recorded');
    % Process close hand level and update GUI for the interested channel
    chCount = 1;
    for i = 1 : 16      
        if chs(i)
            closeHand(i) = mean(featuresClose(:,chCount));
            if get(eval(strcat('handles.pm_selMov',num2str(i))),'Value')==3
                set(eval(strcat('handles.s_thresh',num2str(i))),'Value',closeHand(i));
                newValue = get(eval(strcat('handles.s_thresh',num2str(i))),'Value');
                set(eval(strcat('handles.et_thresh',num2str(i))),'string',sprintf('%d', newValue));
            end
            chCount = chCount + 1;
        end
    end
    % Update the GUI
    for i = 1 : 16
        if chs(i) 
            message = sprintf('%d', MVC(i));
            set(eval(strcat('handles.et_MVC',num2str(i))),'String',message);
            set(eval(strcat('handles.s_thresh',num2str(i))),'Max',MVC(i),'Min',0,'SliderStep',[MVC(i)/100 MVC(i)/100]);
        end
    end
    drawnow;
    % save data 
    save('thresholdsCalibration.mat','featuresNoise','featuresOpen','featuresClose','openHand','closeHand','MVC');
    set(handles.t_msg,'String','Thresholds Calibration completed');
    
    % analyze data to check which channel maximize the distance between the
    % minimum and the maximum voluntary contractions
    chCount = 1;
    distanceOpen = zeros(1,16);
    distanceClose = zeros(1,16);
    for i = 1 : 16
        if chs(i)
            if openHand(i) > noiseLevel(i)*2
                distanceOpen(i) = MVC(i)-openHand(i);
            end
            if closeHand(i) > noiseLevel(i)*2
              distanceClose(i) = MVC(i)-closeHand(i);
            end
            chCount = chCount + 1;
        end
    end
    [rangeOpen chOpen] = max(distanceOpen);
    [rangeClose chClose] = max(distanceClose);
    if chOpen == chClose
        distanceClose(chClose) = 0;
        [rangeClose chClose] = max(distanceClose);
    end 
    clc
    disp('Direct-Control: autocalibration procedure for control thresholds')
    message = sprintf('Suggested control channel for open hand is: %d (range %f)', chOpen, rangeOpen);
    disp(message)
    message = sprintf('Suggested control channel for close hand is: %d (range %f)', chClose, rangeClose);
    disp(message)


% --------------------------------------------------------------------
function menu_ramp_Callback(hObject, eventdata, handles)
% hObject    handle to menu_ramp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    global MVC;
    global chs;

    set(handles.txt_ramp, 'Visible', 'on');
    
    % Selected channels
    chs = [];
    for i = 1 : 16
        chs(i) = get(eval(strcat('handles.cb_',num2str(i))),'Value');
    end
    chIdxExtra = 0;     
    chIdxUpper = bitshift(sum(bitset(0,find(chs==1))),-8);
    chIdxLower = bitand(sum(bitset(0,find(chs==1))),255);
    nCh = size(find(chs==1),2);
    
    resetValues = get(handles.cb_reset,'Value');  
    if resetValues
        for i = 1 : 16
            MVC(i) = 0;
            set(eval(strcat('handles.et_MVC',num2str(i))),'String','');
            set(eval(strcat('handles.et_thresh',num2str(i))),'String','');
            set(eval(strcat('handles.s_thresh',num2str(i))),'Value',0);
        end
    end
    
    % Find open and close channels
    openHandChannel = 0;
    closeHandChannel = 0;
    for i = 1 : 16 
        if get(eval(strcat('handles.pm_selMov',num2str(i))),'Value')==2
            openHandChannel = i;
        end
        if get(eval(strcat('handles.pm_selMov',num2str(i))),'Value')==3
            closeHandChannel = i;
        end
    end
    if (openHandChannel==0) || (closeHandChannel==0)
        errordlg('open and close channels must be assigned before proceeding!');
        return
    end
   
    % Initialization of progress bar
    set(handles.p_1,'YLimMode','manual');
    set(handles.p_2,'YLimMode','manual');
    
    % recover tWs and oWs info from GUI father (if it exists)
    if isfield(handles,'sF')
        sF = handles.sF;
    else
        sF = 1000;
    end
    if isfield(handles,'tWs')
        tWs = handles.tWs;
    else
        tWs = 0.05*sF;
    end
    if isfield(handles,'oWs')
        oWs = handles.oWs;
    else   
        oWs = sF*0.025;
    end
     
    % Get connection object
    if isfield(handles,'obj')
        obj = handles.obj;
    else
        set(handles.t_msg,'String','No connection obj found');   
        return;
    end   
    tW = tWs/sF;
    oW = oWs/sF;
    recTime = 3;
    samples = round(recTime/(tW-oW));
    featureTime = (tWs-oWs)/sF;
    maxCount = round((1/featureTime)/2);
    if maxCount < 1
        maxCount = 1;
    end
    refreshBarsCount = 0;
    
    % Set up receiving buffer
    obj.InputBufferSize = 4*8*samples*5;
    % Open the connection
    fopen(obj);
    % Read available data and discard it
    if obj.BytesAvailable > 0
        fread(obj,obj.BytesAvailable,'uint8');    % Read the samples        
    end  
 
    % Set the parameters for features extraction
    FeaturesEnables(1) = 1;
    FeaturesEnables(2) = 0;
    FeaturesEnables(3) = 0;
    FeaturesEnables(4) = 0;
    FeaturesEnables(5) = 0;
    nFeatures = sum(FeaturesEnables(:));
%     fwrite(obj,'f','char');
%     replay = char(fread(obj,1,'char'));
%     if strcmp(replay,'f')
%         fwrite(obj,tWs,'float');
%         fwrite(obj,oWs,'float');
%         fwrite(obj,nFeatures,'char');
%         for i = 1:size(FeaturesEnables,2)
%             fwrite(obj,FeaturesEnables(i),'char');
%         end
%         replay = char(fread(obj,1,'char'));
%         if strcmp(replay,'f');
%             set(handles.t_msg,'String','Features extraction parameters set');
%         else
%             set(handles.t_msg,'String','Error Setting Features extraction parameters'); 
%             fclose(obj);
%             return
%         end
%     else
%         set(handles.t_msg,'String','Error Setting Features extraction parameters'); 
%         fclose(obj);
%         return
%     end
    
    % Threshold Calibration start
    set(handles.t_msg,'String','Ramp Tracking Recording start');
    pause(2)
    % rest recording
    set(handles.t_msg,'String','Prepare to rest');
    pause(2)
    set(handles.t_msg,'String','Prepare to rest......3');
    pause(1)
    set(handles.t_msg,'String','Prepare to rest......2');
    pause(1)
    set(handles.t_msg,'String','Prepare to rest......1');
    pause(1)
    set(handles.t_msg,'String','Relax, avoid any muscle contraction');
    % Read available data and discard it
    if obj.BytesAvailable > 0
        fread(obj,obj.BytesAvailable,'uint8');      
    end 
    % Start the features extraction
    fwrite(obj,'X','uint8');
    fwrite(obj,chIdxExtra,'uint8'); % keep compatibility of old GUI with new channels
    fwrite(obj,chIdxUpper,'uint8');
    fwrite(obj,chIdxLower,'uint8');
    fwrite(obj,nCh,'uint8');
    replay = char(fread(obj,1,'char'));
    if strcmp(replay,'X')
        set(handles.t_msg,'String','Features reception Start');
    else
        set(handles.t_msg,'String','Error Start'); 
        fclose(obj);
        return
    end
    drawnow;   
    % throw away the first samples
    byteData = fread(obj,(nFeatures*nCh),'float32');
    byteData = fread(obj,(nFeatures*nCh),'float32');
    byteData = fread(obj,(nFeatures*nCh),'float32');    
    refreshBarsCount = 0;
    for i = 1:samples
        % (4bytes X features X nCh channels)
        byteData = fread(obj,(nFeatures*nCh),'float32');                             
        featuresNoise(i,:) = byteData; 
        % update the MVC level
        chCount = 1;
        for j = 1 : 16
            if chs(j)
                if byteData(chCount) > MVC(j)
                    MVC(j) = byteData(chCount);
                end
                chCount = chCount + 1;
            end
        end 
        refreshBarsCount = refreshBarsCount+1;
        % get the plot routines faster
        if refreshBarsCount == maxCount
            UpdateBars(byteData, handles);   
            refreshBarsCount = 0;
        end
    end
    % Stop the aquisition
    fwrite(obj,'T','char');
    set(handles.t_msg,'String','Rest state Recorded');
    % Process noise level
    chCount = 1;
    for i = 1 : 16
        if chs(i)
            noiseLevel(i) = mean(featuresNoise(:,chCount));
            set(eval(strcat('handles.s_thresh',num2str(i))),'Value',noiseLevel(i));
            newValue = get(eval(strcat('handles.s_thresh',num2str(i))),'Value');
            set(eval(strcat('handles.et_thresh',num2str(i))),'string',sprintf('%d', newValue));
            chCount = chCount + 1;
        end
    end
    % Update the GUI
    for i = 1 : 16
        if chs(i) 
            message = sprintf('%d', MVC(i));
            set(eval(strcat('handles.et_MVC',num2str(i))),'String',message);
            set(eval(strcat('handles.s_thresh',num2str(i))),'Max',MVC(i),'Min',0,'SliderStep',[MVC(i)/100 MVC(i)/100]);
        end
    end
    drawnow;
    
    % open hand recording maximum
    set(handles.t_msg,'String','Prepare to open the hand at the maximum contraction');
    pause(3)
    set(handles.t_msg,'String','Prepare to open the hand at the maximum contraction.....3');
    pause(1)
    set(handles.t_msg,'String','Prepare to open the hand at the maximum contraction.....2');
    pause(1)
    set(handles.t_msg,'String','Prepare to open the hand at the maximum contraction.....1');
    pause(1)
    set(handles.t_msg,'String','Open the hand at the maximum contraction');
    % Read available data and discard it
    if obj.BytesAvailable > 0
        fread(obj,obj.BytesAvailable,'uint8');      
    end  
    % Start the features extraction
    fwrite(obj,'X','uint8');
    fwrite(obj,chIdxExtra,'uint8'); % keep compatibility of old GUI with new channels
    fwrite(obj,chIdxUpper,'uint8');
    fwrite(obj,chIdxLower,'uint8');
    fwrite(obj,nCh,'uint8');
    replay = char(fread(obj,1,'char'));
    if strcmp(replay,'X')
        set(handles.t_msg,'String','Features reception Start');
    else
        set(handles.t_msg,'String','Error Start'); 
        fclose(obj);
        return
    end
    drawnow; 
    % throw away the first samples
    byteData = fread(obj,(nFeatures*nCh),'float32');
    byteData = fread(obj,(nFeatures*nCh),'float32');
    byteData = fread(obj,(nFeatures*nCh),'float32');    
    refreshBarsCount = 0;
    for i = 1:samples
        % (4bytes X features X nCh channels)
        byteData = fread(obj,(nFeatures*nCh),'float32');                             
        featuresOpen(i,:) = byteData; 
        % update the MVC level
        chCount = 1;
        for j = 1 : 16
            if chs(j)
                if byteData(chCount) > MVC(j)
                    MVC(j) = byteData(chCount);
                end
                chCount = chCount + 1;
            end
        end 
        refreshBarsCount = refreshBarsCount+1;
        % get the plot routines faster
        if refreshBarsCount == maxCount
            UpdateBars(byteData, handles);   
            refreshBarsCount = 0;
        end
    end
    % Stop the aquisition
    fwrite(obj,'T','char');
    set(handles.t_msg,'String','Open Hand MVC Recorded');
    % Process open hand level and update GUI for the interested channel
    chCount = 0;
    for i = 1:size(chs,2)
        if chs(i)
            chCount = chCount + 1;
        end
        if i == openHandChannel
            openHandMVC = mean(featuresOpen(:,chCount));
            byteDataOpen = chCount;
        end
    end
    % Update the GUI for open hand channel
    message = sprintf('%d', MVC(openHandChannel));
    set(eval(strcat('handles.et_MVC',num2str(openHandChannel))),'String',message);
    drawnow;
    
    % close hand recording maximum
    set(handles.t_msg,'String','Prepare to close the hand at the maximum contraction');
    pause(3)
    set(handles.t_msg,'String','Prepare to close the hand at the maximum contraction.....3');
    pause(1)
    set(handles.t_msg,'String','Prepare to close the hand at the maximum contraction.....2');
    pause(1)
    set(handles.t_msg,'String','Prepare to close the hand at the maximum contraction.....1');
    pause(1)
    set(handles.t_msg,'String','Close the hand at the maximum contraction');
    % Read available data and discard it
    if obj.BytesAvailable > 0
        fread(obj,obj.BytesAvailable,'uint8');      
    end 
    % Start the features extraction
    fwrite(obj,'X','uint8');
    fwrite(obj,chIdxExtra,'uint8'); % keep compatibility of old GUI with new channels
    fwrite(obj,chIdxUpper,'uint8');
    fwrite(obj,chIdxLower,'uint8');
    fwrite(obj,nCh,'uint8');
    replay = char(fread(obj,1,'char'));
    if strcmp(replay,'X')
        set(handles.t_msg,'String','Features reception Start');
    else
        set(handles.t_msg,'String','Error Start'); 
        fclose(obj);
        return
    end
    drawnow;   
    % throw away the first samples
    byteData = fread(obj,(nFeatures*nCh),'float32');
    byteData = fread(obj,(nFeatures*nCh),'float32');
    byteData = fread(obj,(nFeatures*nCh),'float32');    
    refreshBarsCount = 0;
    for i = 1:samples
        byteData = fread(obj,(nFeatures*nCh),'float32');                             
        featuresClose(i,:) = byteData; 
        % update the MVC level
        chCount = 1;
        for j = 1 : 16
            if chs(j)
                if byteData(chCount) > MVC(j)
                    MVC(j) = byteData(chCount);
                end
                chCount = chCount + 1;
            end
        end 
        refreshBarsCount = refreshBarsCount+1;
        % get the plot routines faster
        if refreshBarsCount == maxCount
            UpdateBars(byteData, handles);   
            refreshBarsCount = 0;
        end
    end
    % Stop the aquisition
    fwrite(obj,'T','char');
    set(handles.t_msg,'String','Close Hand MVC Recorded');
    % Process close hand level and update GUI for the interested channel
    chCount = 0;
    for i = 1:size(chs,2)
        if chs(i)
            chCount = chCount + 1;
        end
        if i == closeHandChannel
            closeHandMVC = mean(featuresClose(:,chCount));
            byteDataClose = chCount;
        end
    end
    % Update the GUI for close hand channel
    message = sprintf('%d', MVC(closeHandChannel));
    set(eval(strcat('handles.et_MVC',num2str(closeHandChannel))),'String',message);
    drawnow;
    
    % setup ramp recording 
    if (byteDataOpen == 0) || (byteDataClose == 0)
        errordlg('open and close channels must be assigned before proceeding!');
        return
    end
    recTime = 5;
    samples = round(recTime/(tW-oW));
    maxCount = round((1/featureTime)/recTime)+nCh*2;
    % make the ramp objects visible
    set(handles.ax_ramp,'Visible','on');
    set(handles.txt_ramp,'Visible','on');
    % Init the effort tracking plot and draw the guide line
    p_effortPlot = plot(handles.ax_ramp,linspace(0,recTime,sF*recTime),linspace(0,100,sF*recTime),'LineWidth',2);
    ylim(handles.ax_ramp, [0 100]);
    xlim(handles.ax_ramp, [0 recTime]);
    axes(handles.ax_ramp)
    hLine = line('XData', 0, 'YData', 0, 'Color', 'r', 'Marker', 'o', 'MarkerSize', 8, 'LineWidth', 2);
    % Init the ramp plots
    p_open = plot(handles.ax_open,0,0);
    ylim(handles.ax_open, [0 MVC(openHandChannel)]);
    xlim(handles.ax_open, [0 recTime]);
    p_close = plot(handles.ax_close,0,0);
    ylim(handles.ax_close, [0 MVC(closeHandChannel)]);
    xlim(handles.ax_close, [0 recTime]);
    
    % open hand ramp tracking recording
    set(handles.t_msg,'String','Prepare to open the hand following the ramp');
    pause(3)
    set(handles.t_msg,'String','Prepare to open the hand following the ramp.....3');
    pause(1)
    set(handles.t_msg,'String','Prepare to open the hand following the ramp.....2');
    pause(1)
    set(handles.t_msg,'String','Prepare to open the hand following the ramp.....1');
    pause(1)
    set(handles.t_msg,'String','Open the hand following the ramp');
    % Read available data and discard it
    if obj.BytesAvailable > 0
        fread(obj,obj.BytesAvailable,'uint8');      
    end  
    % Start the features extraction
    fwrite(obj,'X','uint8');
    fwrite(obj,chIdxExtra,'uint8'); % keep compatibility of old GUI with new channels
    fwrite(obj,chIdxUpper,'uint8');
    fwrite(obj,chIdxLower,'uint8');
    fwrite(obj,nCh,'uint8');
    replay = char(fread(obj,1,'char'));
    if strcmp(replay,'X')
        set(handles.t_msg,'String','Features reception Start');
    else
        set(handles.t_msg,'String','Error Start'); 
        fclose(obj);
        return
    end
    drawnow;  
    % throw away the first samples
    byteData = fread(obj,(nFeatures*nCh),'float32');
    byteData = fread(obj,(nFeatures*nCh),'float32');
    byteData = fread(obj,(nFeatures*nCh),'float32');  
    refreshBarsCount = 0;
    tic
    for i = 1:samples
        byteData = fread(obj,(nFeatures*nCh),'float32');                             
        rampOpen(i,:) = byteData; 
        effortRatio = 100*(abs(byteData(byteDataOpen)-noiseLevel(byteDataOpen))/(openHandMVC-noiseLevel(byteDataOpen)));
        if effortRatio > 100
            effortRatio = 100;
        end
        refreshBarsCount = refreshBarsCount+1;
        % get the plot routines faster
        if refreshBarsCount == maxCount
            UpdateBars(byteData, handles); 
            set(hLine,'XData', i*featureTime,'Ydata', effortRatio);
            drawnow expose
            refreshBarsCount = 0;
        end
    end
    % Stop the aquisition
    fwrite(obj,'T','char');
    toc
    set(handles.t_msg,'String','Open Hand RampTrack Recorded');
    drawnow;    
    
    % close hand ramp tracking recording
    set(hLine,'XData', 0,'Ydata', 0);
    set(handles.t_msg,'String','Prepare to close the hand following the ramp');
    pause(3)
    set(handles.t_msg,'String','Prepare to close the hand following the ramp.....3');
    pause(1)
    set(handles.t_msg,'String','Prepare to close the hand following the ramp.....2');
    pause(1)
    set(handles.t_msg,'String','Prepare to close the hand following the ramp.....1');
    pause(1)
    set(handles.t_msg,'String','Close the hand following the ramp');
    % Read available data and discard it
    if obj.BytesAvailable > 0
        fread(obj,obj.BytesAvailable,'uint8');      
    end  
    % Start the features extraction
    fwrite(obj,'X','uint8');
    fwrite(obj,chIdxExtra,'uint8'); % keep compatibility of old GUI with new channels
    fwrite(obj,chIdxUpper,'uint8');
    fwrite(obj,chIdxLower,'uint8');
    fwrite(obj,nCh,'uint8');
    replay = char(fread(obj,1,'char'));
    if strcmp(replay,'X')
        set(handles.t_msg,'String','Features reception Start');
    else
        set(handles.t_msg,'String','Error Start'); 
        fclose(obj);
        return
    end
    drawnow;   
    % throw away the first samples
    byteData = fread(obj,(nFeatures*nCh),'float32');
    byteData = fread(obj,(nFeatures*nCh),'float32');
    byteData = fread(obj,(nFeatures*nCh),'float32');    
    refreshBarsCount = 0;
    tic
    for i = 1:samples
        byteData = fread(obj,(nFeatures*nCh),'float32');                             
        rampClose(i,:) = byteData; 
        effortRatio = 100*(abs(byteData(byteDataClose)-noiseLevel(byteDataClose))/(closeHandMVC-noiseLevel(byteDataClose)));
        if effortRatio > 100
            effortRatio = 100;
        end
        refreshBarsCount = refreshBarsCount+1;
        % get the plot routines faster
        if refreshBarsCount == maxCount
            UpdateBars(byteData, handles); 
            set(hLine,'XData', i*featureTime,'Ydata', effortRatio);
            drawnow expose
            refreshBarsCount = 0;
        end
    end
    % Stop the aquisition
    fwrite(obj,'T','char');
    fclose(obj);
    toc
    set(handles.t_msg,'String','RampTrack Recorded');
    drawnow;
    
    % Save on structure and on file
    testTypeStr = 'ALCD-DC_ramp_recording';
    timeTest = clock;
    year = timeTest(1);
    month = timeTest(2);
    day = timeTest(3);
    hour = timeTest(4);
    min = timeTest(5);
    strSaveName = [testTypeStr '_' num2str(day) '_' num2str(month) '_' num2str(year) '-' num2str(hour) '_' num2str(min) '.mat'];
    rampTrack.noiseLevel = noiseLevel;
    rampTrack.openHandChannel = openHandChannel;
    rampTrack.closeHandChannel = closeHandChannel;
    rampTrack.rampOpen = rampOpen;
    rampTrack.rampClose = rampClose;
    rampTrack.openHandMVC = openHandMVC;
    rampTrack.closeHandMVC = closeHandMVC;
    rampTrack.tW = tW;
    rampTrack.oW = oW;
    rampTrack.featureTime = featureTime;
    save(strSaveName,'rampTrack');
    
    % update plots for open/close hand ramp tracks
    % plot calculated thresholds (MVC and noise and min)
    axes(handles.ax_open)
    plot(linspace(0,recTime,samples),rampOpen(:,byteDataOpen))
    hold on
    handles.openLineMVC = plot(linspace(0,recTime,samples),ones(1,samples)*openHandMVC,'-r','LineWidth',2.5,'ButtonDownFcn', @(hObject,eventdata)GUI_SetDC('startDragOpenLineMVC_Fcn',hObject,eventdata,guidata(hObject)));
    plot(linspace(0,recTime,samples),ones(1,samples)*noiseLevel(byteDataOpen),'g');
    handles.openLineThresh = plot(linspace(0,recTime,samples),ones(1,samples)*openHandMVC/2,'-b','LineWidth',2.5,'ButtonDownFcn',@(hObject,eventdata)GUI_SetDC('startDragOpenLineThresh_Fcn',hObject,eventdata,guidata(hObject)));
    hold off
    axes(handles.ax_close)
    plot(linspace(0,recTime,samples),rampClose(:,byteDataClose))
    hold on
    handles.closeLineMVC = plot(linspace(0,recTime,samples),ones(1,samples)*closeHandMVC,'-r','LineWidth',2.5,'ButtonDownFcn', @(hObject,eventdata)GUI_SetDC('startDragCloseLineMVC_Fcn',hObject,eventdata,guidata(hObject)));
    plot(linspace(0,recTime,samples),ones(1,samples)*noiseLevel(byteDataClose),'g');
    handles.closeLineThresh = plot(linspace(0,recTime,samples),ones(1,samples)*closeHandMVC/2,'-b','LineWidth',2.5,'ButtonDownFcn',@(hObject,eventdata)GUI_SetDC('startDragCloseLineThresh_Fcn',hObject,eventdata,guidata(hObject)));
    hold off
    
    set(handles.txt_ramp, 'Visible', 'off');
    % Update handles structure
    guidata(hObject, handles);


% --------------------------------------------------------------------
function menu_loadRamp_Callback(hObject, eventdata, handles)
% hObject    handle to menu_loadRamp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Browse and load a ramp recording session file
    [file, path] = uigetfile({'*.mat'});
    if ~isequal(file, 0)
        [pathstr,name,ext] = fileparts(file);
        if(strcmp(ext,'.mat'))
            load([path,file]);
            if (~exist('rampTrack','var'))   
                disp('Not a valid rampTrack file');
                errordlg('Not a valid rampTrack file','Error');
                return;   
            end
        else
            disp('Not a valid rampTrack file');
            errordlg('Not a valid rampTrack file','Error');
            return; 
        end
    end
    
    % Copy on structure from the file
    noiseLevel = rampTrack.noiseLevel;
    openHandChannel = rampTrack.openHandChannel;
    closeHandChannel = rampTrack.closeHandChannel;
    rampOpen = rampTrack.rampOpen;
    rampClose = rampTrack.rampClose;
    openHandMVC = rampTrack.openHandMVC;
    closeHandMVC = rampTrack.closeHandMVC;
    featureTime = rampTrack.featureTime;
    recTime = length(rampOpen)*featureTime;
    samples = round(recTime/featureTime);

    % find channel for open and close hand
    counter = 0;
    chs = zeros(1,16);
    chs(openHandChannel) = 1;
    chs(closeHandChannel) = 1;
    for i = 1:size(chs,2)
        if chs(i)
            counter = counter+1;
        end
        if i == openHandChannel
            byteDataOpen = counter;
        end
        if i == closeHandChannel
            byteDataClose = counter;
        end
    end
    
    % Update the GUI
    for i = 1 : 16
        if chs(i) && (i==openHandChannel)
            message = sprintf('%d', openHandMVC);
            set(eval(strcat('handles.et_MVC',num2str(i))),'String',message);
            set(eval(strcat('handles.s_thresh',num2str(i))),'Max',openHandMVC,'Min',0,'SliderStep',[openHandMVC/100 openHandMVC/100]);
            set(eval(strcat('handles.pm_selMov',num2str(i))),'Value',2);
            set(eval(strcat('handles.cb_',num2str(i))),'Value',1);
        elseif chs(i) && (i==closeHandChannel)
            message = sprintf('%d', closeHandMVC);
            set(eval(strcat('handles.et_MVC',num2str(i))),'String',message);
            set(eval(strcat('handles.s_thresh',num2str(i))),'Max',closeHandMVC,'Min',0,'SliderStep',[closeHandMVC/100 closeHandMVC/100]);
            set(eval(strcat('handles.pm_selMov',num2str(i))),'Value',3);
            set(eval(strcat('handles.cb_',num2str(i))),'Value',1);
        else
            set(eval(strcat('handles.pm_selMov',num2str(i))),'Value',1);
            set(eval(strcat('handles.et_MVC',num2str(i))),'String','');           
            set(eval(strcat('handles.cb_',num2str(i))),'Value',0);
        end
        set(eval(strcat('handles.et_thresh',num2str(i))),'String','');
        set(eval(strcat('handles.s_thresh',num2str(i))),'Value',0);
    end
    drawnow;
    
    % update plots for open/close hand ramp tracks
    % plot calculated thresholds (MVC and noise and min)
    axes(handles.ax_open)
    plot(linspace(0,recTime,samples),rampOpen(:,byteDataOpen))
    hold on
    handles.openLineMVC = plot(linspace(0,recTime,samples),ones(1,samples)*openHandMVC,'-r','LineWidth',2.5,'ButtonDownFcn', @(hObject,eventdata)GUI_SetDC('startDragOpenLineMVC_Fcn',hObject,eventdata,guidata(hObject)));
    plot(linspace(0,recTime,samples),ones(1,samples)*noiseLevel(byteDataOpen),'g');
    handles.openLineThresh = plot(linspace(0,recTime,samples),ones(1,samples)*openHandMVC/2,'-b','LineWidth',2.5,'ButtonDownFcn',@(hObject,eventdata)GUI_SetDC('startDragOpenLineThresh_Fcn',hObject,eventdata,guidata(hObject)));
    hold off
    axes(handles.ax_close)
    plot(linspace(0,recTime,samples),rampClose(:,byteDataClose))
    hold on
    handles.closeLineMVC = plot(linspace(0,recTime,samples),ones(1,samples)*closeHandMVC,'-r','LineWidth',2.5,'ButtonDownFcn', @(hObject,eventdata)GUI_SetDC('startDragCloseLineMVC_Fcn',hObject,eventdata,guidata(hObject)));
    plot(linspace(0,recTime,samples),ones(1,samples)*noiseLevel(byteDataClose),'g');
    handles.closeLineThresh = plot(linspace(0,recTime,samples),ones(1,samples)*closeHandMVC/2,'-b','LineWidth',2.5,'ButtonDownFcn',@(hObject,eventdata)GUI_SetDC('startDragCloseLineThresh_Fcn',hObject,eventdata,guidata(hObject)));
    hold off
    
    % Update handles structure
    guidata(hObject, handles);

function et_MVC16_Callback(hObject, eventdata, handles)
% hObject    handle to et_MVC16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_MVC16 as text
%        str2double(get(hObject,'String')) returns contents of et_MVC16 as a double


% --- Executes during object creation, after setting all properties.
function et_MVC16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_MVC16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_selMov16.
function pm_selMov16_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selMov16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selMov16 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selMov16


% --- Executes during object creation, after setting all properties.
function pm_selMov16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selMov16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_thresh16_Callback(hObject, eventdata, handles)
% hObject    handle to et_thresh16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_thresh16 as text
%        str2double(get(hObject,'String')) returns contents of et_thresh16 as a double


% --- Executes during object creation, after setting all properties.
function et_thresh16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_thresh16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function s_thresh16_Callback(hObject, eventdata, handles)
% hObject    handle to s_thresh16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
newValue = get(hObject,'Value');
newValue = sprintf('%d', newValue);
set(handles.et_thresh16,'string',newValue);


% --- Executes during object creation, after setting all properties.
function s_thresh16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_thresh16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function et_MVC12_Callback(hObject, eventdata, handles)
% hObject    handle to et_MVC12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_MVC12 as text
%        str2double(get(hObject,'String')) returns contents of et_MVC12 as a double


% --- Executes during object creation, after setting all properties.
function et_MVC12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_MVC12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_selMov12.
function pm_selMov12_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selMov12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selMov12 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selMov12


% --- Executes during object creation, after setting all properties.
function pm_selMov12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selMov12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_thresh12_Callback(hObject, eventdata, handles)
% hObject    handle to et_thresh12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_thresh12 as text
%        str2double(get(hObject,'String')) returns contents of et_thresh12 as a double


% --- Executes during object creation, after setting all properties.
function et_thresh12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_thresh12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function s_thresh12_Callback(hObject, eventdata, handles)
% hObject    handle to s_thresh12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
newValue = get(hObject,'Value');
newValue = sprintf('%d', newValue);
set(handles.et_thresh12,'string',newValue);


% --- Executes during object creation, after setting all properties.
function s_thresh12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_thresh12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function et_MVC15_Callback(hObject, eventdata, handles)
% hObject    handle to et_MVC15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_MVC15 as text
%        str2double(get(hObject,'String')) returns contents of et_MVC15 as a double


% --- Executes during object creation, after setting all properties.
function et_MVC15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_MVC15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_selMov15.
function pm_selMov15_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selMov15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selMov15 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selMov15


% --- Executes during object creation, after setting all properties.
function pm_selMov15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selMov15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_thresh15_Callback(hObject, eventdata, handles)
% hObject    handle to et_thresh15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_thresh15 as text
%        str2double(get(hObject,'String')) returns contents of et_thresh15 as a double


% --- Executes during object creation, after setting all properties.
function et_thresh15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_thresh15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function s_thresh15_Callback(hObject, eventdata, handles)
% hObject    handle to s_thresh15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
newValue = get(hObject,'Value');
newValue = sprintf('%d', newValue);
set(handles.et_thresh15,'string',newValue);


% --- Executes during object creation, after setting all properties.
function s_thresh15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_thresh15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function et_MVC11_Callback(hObject, eventdata, handles)
% hObject    handle to et_MVC11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_MVC11 as text
%        str2double(get(hObject,'String')) returns contents of et_MVC11 as a double


% --- Executes during object creation, after setting all properties.
function et_MVC11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_MVC11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_selMov11.
function pm_selMov11_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selMov11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selMov11 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selMov11


% --- Executes during object creation, after setting all properties.
function pm_selMov11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selMov11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_thresh11_Callback(hObject, eventdata, handles)
% hObject    handle to et_thresh11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_thresh11 as text
%        str2double(get(hObject,'String')) returns contents of et_thresh11 as a double


% --- Executes during object creation, after setting all properties.
function et_thresh11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_thresh11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function s_thresh11_Callback(hObject, eventdata, handles)
% hObject    handle to s_thresh11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
newValue = get(hObject,'Value');
newValue = sprintf('%d', newValue);
set(handles.et_thresh11,'string',newValue);


% --- Executes during object creation, after setting all properties.
function s_thresh11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_thresh11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function et_MVC13_Callback(hObject, eventdata, handles)
% hObject    handle to et_MVC13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_MVC13 as text
%        str2double(get(hObject,'String')) returns contents of et_MVC13 as a double


% --- Executes during object creation, after setting all properties.
function et_MVC13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_MVC13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_thresh13_Callback(hObject, eventdata, handles)
% hObject    handle to et_thresh13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_thresh13 as text
%        str2double(get(hObject,'String')) returns contents of et_thresh13 as a double


% --- Executes during object creation, after setting all properties.
function et_thresh13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_thresh13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function s_thresh13_Callback(hObject, eventdata, handles)
% hObject    handle to s_thresh13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
newValue = get(hObject,'Value');
newValue = sprintf('%d', newValue);
set(handles.et_thresh13,'string',newValue);


% --- Executes during object creation, after setting all properties.
function s_thresh13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_thresh13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in pm_selMov13.
function pm_selMov13_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selMov13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selMov13 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selMov13


% --- Executes during object creation, after setting all properties.
function pm_selMov13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selMov13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_MVC14_Callback(hObject, eventdata, handles)
% hObject    handle to et_MVC14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_MVC14 as text
%        str2double(get(hObject,'String')) returns contents of et_MVC14 as a double


% --- Executes during object creation, after setting all properties.
function et_MVC14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_MVC14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_selMov14.
function pm_selMov14_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selMov14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selMov14 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selMov14


% --- Executes during object creation, after setting all properties.
function pm_selMov14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selMov14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_thresh14_Callback(hObject, eventdata, handles)
% hObject    handle to et_thresh14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_thresh14 as text
%        str2double(get(hObject,'String')) returns contents of et_thresh14 as a double


% --- Executes during object creation, after setting all properties.
function et_thresh14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_thresh14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function s_thresh14_Callback(hObject, eventdata, handles)
% hObject    handle to s_thresh14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
newValue = get(hObject,'Value');
newValue = sprintf('%d', newValue);
set(handles.et_thresh14,'string',newValue);


% --- Executes during object creation, after setting all properties.
function s_thresh14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_thresh14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function et_MVC10_Callback(hObject, eventdata, handles)
% hObject    handle to et_MVC10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_MVC10 as text
%        str2double(get(hObject,'String')) returns contents of et_MVC10 as a double


% --- Executes during object creation, after setting all properties.
function et_MVC10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_MVC10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_selMov10.
function pm_selMov10_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selMov10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selMov10 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selMov10


% --- Executes during object creation, after setting all properties.
function pm_selMov10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selMov10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_thresh10_Callback(hObject, eventdata, handles)
% hObject    handle to et_thresh10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_thresh10 as text
%        str2double(get(hObject,'String')) returns contents of et_thresh10 as a double


% --- Executes during object creation, after setting all properties.
function et_thresh10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_thresh10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function s_thresh10_Callback(hObject, eventdata, handles)
% hObject    handle to s_thresh10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
newValue = get(hObject,'Value');
newValue = sprintf('%d', newValue);
set(handles.et_thresh10,'string',newValue);


% --- Executes during object creation, after setting all properties.
function s_thresh10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_thresh10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit26_Callback(hObject, eventdata, handles)
% hObject    handle to et_MVC9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_MVC9 as text
%        str2double(get(hObject,'String')) returns contents of et_MVC9 as a double


% --- Executes during object creation, after setting all properties.
function edit26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_MVC9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_selMov9.
function popupmenu15_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selMov9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selMov9 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selMov9


% --- Executes during object creation, after setting all properties.
function popupmenu15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selMov9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider11_Callback(hObject, eventdata, handles)
% hObject    handle to s_thresh9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_thresh9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in cb_9.
function cb_9_Callback(hObject, eventdata, handles)
% hObject    handle to cb_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_9


% --- Executes on button press in cb_10.
function cb_10_Callback(hObject, eventdata, handles)
% hObject    handle to cb_10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_10


% --- Executes on button press in cb_3.
function checkbox23_Callback(hObject, eventdata, handles)
% hObject    handle to cb_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_3


% --- Executes on button press in cb_11.
function cb_11_Callback(hObject, eventdata, handles)
% hObject    handle to cb_11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_11


% --- Executes on button press in cb_4.
function checkbox25_Callback(hObject, eventdata, handles)
% hObject    handle to cb_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_4


% --- Executes on button press in cb_12.
function cb_12_Callback(hObject, eventdata, handles)
% hObject    handle to cb_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_12


% --- Executes on button press in cb_5.
function checkbox27_Callback(hObject, eventdata, handles)
% hObject    handle to cb_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_5


% --- Executes on button press in cb_13.
function cb_13_Callback(hObject, eventdata, handles)
% hObject    handle to cb_13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_13


% --- Executes on button press in cb_6.
function checkbox29_Callback(hObject, eventdata, handles)
% hObject    handle to cb_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_6


% --- Executes on button press in cb_14.
function cb_14_Callback(hObject, eventdata, handles)
% hObject    handle to cb_14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_14


% --- Executes on button press in cb_7.
function checkbox31_Callback(hObject, eventdata, handles)
% hObject    handle to cb_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_7


% --- Executes on button press in cb_15.
function cb_15_Callback(hObject, eventdata, handles)
% hObject    handle to cb_15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_15


% --- Executes on button press in cb_8.
function checkbox33_Callback(hObject, eventdata, handles)
% hObject    handle to cb_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_8


% --- Executes on button press in cb_16.
function cb_16_Callback(hObject, eventdata, handles)
% hObject    handle to cb_16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_16


% --- Executes on button press in pb_default.
function pb_default_Callback(hObject, eventdata, handles)
% hObject    handle to pb_default (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
def = [0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1];
for i = 1 : 16
    if def(i)
        set(eval(strcat('handles.cb_',num2str(i))),'Value',1);
    else
        set(eval(strcat('handles.cb_',num2str(i))),'Value',0);
    end
end

% --- Executes on button press in pb_all.
function pb_all_Callback(hObject, eventdata, handles)
% hObject    handle to pb_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for i = 1 : 16
    set(eval(strcat('handles.cb_',num2str(i))),'Value',1);
end

% --- Executes on button press in pb_none.
function pb_none_Callback(hObject, eventdata, handles)
% hObject    handle to pb_none (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

for i = 1 : 16
    set(eval(strcat('handles.cb_',num2str(i))),'Value',0);
end

% --------------------------------------------------------------------
function menu_info_Callback(hObject, eventdata, handles)
% hObject    handle to menu_info (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msg = {'1) use the checkboxes to select all epimysial channels (press default for standard configuration)', '2) check range of channels with automatic procedure', ...
    '3) select the suggested channels for open and close, set the movements using the popupmenus and discard the others channels unchecking their checkboxes', ...
    '4) run ramp track recording', '5) adjust the thresholds for open and close dragging the MVC and THRESH lines', '6) write the settings on the system and test it', ...
    '7) reiterate this process untill you find an optimal result'};
helpdlg(msg,'fitting procedure')
