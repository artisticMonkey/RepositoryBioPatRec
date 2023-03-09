function varargout = GUI_SetDC_24chs(varargin)
% GUI_SETDC MATLAB code for GUI_SetDC_24chs.fig
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
%      applied to the GUI before GUI_SetDC_24chs_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_SetDC_24chs_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_SetDC_24chs

% Last Modified by GUIDE v2.5 26-Sep-2022 12:54:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_SetDC_24chs_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_SetDC_24chs_OutputFcn, ...
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


% --- Executes just before GUI_SetDC_24chs is made visible.
function GUI_SetDC_24chs_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_SetDC_24chs (see VARARGIN)

global movs;

% Choose default command line output for GUI_SetDC_24chs
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
set(handles.p_1,'Xticklabel','');
set(handles.p_2,'Xticklabel','');
set(handles.p_3,'Xticklabel','');
set(handles.p_4,'Xticklabel','');
set(handles.p_5,'Xticklabel','');
set(handles.p_6,'Xticklabel','');
set(handles.p_7,'Xticklabel','');
set(handles.p_8,'Xticklabel','');
set(handles.p_9,'Xticklabel','');
set(handles.p_1,'Yticklabel','');
set(handles.p_2,'Yticklabel','');
set(handles.p_3,'Yticklabel','');
set(handles.p_4,'Yticklabel','');
set(handles.p_5,'Yticklabel','');
set(handles.p_6,'Yticklabel','');
set(handles.p_7,'Yticklabel','');
set(handles.p_8,'Yticklabel','');
set(handles.p_9,'Yticklabel','');
set(handles.p_1,'ylim',[0 1]);
set(handles.p_2,'ylim',[0 1]);
set(handles.p_3,'ylim',[0 1]);
set(handles.p_4,'ylim',[0 1]);
set(handles.p_5,'ylim',[0 1]);
set(handles.p_6,'ylim',[0 1]);
set(handles.p_7,'ylim',[0 1]);
set(handles.p_8,'ylim',[0 1]);
set(handles.p_9,'ylim',[0 1]);
set(handles.ax_ramp,'Xticklabel','');
set(handles.ax_open,'Xticklabel','');
set(handles.ax_close,'Xticklabel','');
set(handles.ax_ramp,'Yticklabel','');
set(handles.ax_open,'Yticklabel','');
set(handles.ax_close,'Yticklabel','');
set(handles.ax_pronation,'Yticklabel','');
set(handles.ax_pronation,'Yticklabel','');
set(handles.ax_supination,'Yticklabel','');
set(handles.ax_supination,'Yticklabel','');

set(hObject, 'WindowButtonUpFcn', @(hObject,eventdata)GUI_SetDC_24chs('stopDragFcn',hObject,eventdata,guidata(hObject)));

% movement structure
movs{1}.name = 'open hand';
movs{1}.id = 1;
movs{2}.name = 'close hand';
movs{2}.id = 2;
movs{3}.name = 'pronation';
movs{3}.id = 4;
movs{4}.name = 'supination';
movs{4}.id = 8;
movs{5}.name = 'wrist flex';
movs{5}.id = 64;
movs{6}.name = 'wrist extend';
movs{6}.id = 128;
movs{7}.name = 'elbow flex';
movs{7}.id = 16;
movs{8}.name = 'elbow extend';
movs{8}.id = 32;
movs{9}.name = 'switch';
movs{9}.id = 129;
for i = 1:9
    movs{i}.active = 0;
    movs{i}.chAcqIndex = 0;
    movs{i}.motorThresh = 0;
    movs{i}.mvcLevel = 0;
    movs{i}.pwmOutput = 0;
end
movs{10}.name = 'co-contraction';
movs{10}.id = 130;
movs{10}.active = 0;
movs{10}.pwmOutput = 0;
movs{10}.thresh1 = 0;
movs{10}.thresh2 = 0;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_SetDC_24chs wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_SetDC_24chs_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


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


% --- Executes on selection change in pm_selCh1.
function pm_selCh1_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selCh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selCh1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selCh1


% --- Executes during object creation, after setting all properties.
function pm_selCh1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selCh1 (see GCBO)
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


% --- Executes on selection change in pm_selCh8.
function pm_selCh8_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selCh8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selCh8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selCh8


% --- Executes during object creation, after setting all properties.
function pm_selCh8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selCh8 (see GCBO)
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


% --- Executes on selection change in pm_selCh4.
function pm_selCh4_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selCh4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selCh4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selCh4


% --- Executes during object creation, after setting all properties.
function pm_selCh4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selCh4 (see GCBO)
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


% --- Executes on selection change in pm_selCh7.
function pm_selCh7_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selCh7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selCh7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selCh7


% --- Executes during object creation, after setting all properties.
function pm_selCh7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selCh7 (see GCBO)
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


% --- Executes on selection change in pm_selCh3.
function pm_selCh3_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selCh3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selCh3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selCh3


% --- Executes during object creation, after setting all properties.
function pm_selCh3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selCh3 (see GCBO)
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


% --- Executes on selection change in pm_selCh5.
function pm_selCh5_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selCh5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selCh5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selCh5


% --- Executes during object creation, after setting all properties.
function pm_selCh5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selCh5 (see GCBO)
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


% --- Executes on selection change in pm_selCh6.
function pm_selCh6_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selCh6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selCh6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selCh6


% --- Executes during object creation, after setting all properties.
function pm_selCh6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selCh6 (see GCBO)
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


% --- Executes on selection change in pm_selCh2.
function pm_selCh2_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selCh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selCh2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selCh2


% --- Executes during object creation, after setting all properties.
function pm_selCh2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selCh2 (see GCBO)
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


% --- Executes on button press in pb_start.
function pb_start_Callback(hObject, eventdata, handles)
% hObject    handle to pb_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    global movs;
    global chs;
    
    checkNoiseLevel = get(handles.cb_noiseLevel,'Value'); 

    % Selected movements and channels
    chs = zeros(1,24);
    for i = 1 : 9
        if get(eval(strcat('handles.pm_selCh',num2str(i))),'Value') ~= 1
            movs{i}.active = 1;
            movs{i}.chAcqIndex = get(eval(strcat('handles.pm_selCh',num2str(i))),'Value')-1;
            chs(get(eval(strcat('handles.pm_selCh',num2str(i))),'Value')-1) = i; 
            movs{i}.data = 0;
        else
           movs{i}.active = 0; 
           movs{i}.chAcqIndex = 0;
           movs{i}.motorThresh = 0;
           movs{i}.mvcLevel = 0;
           movs{i}.data = 0;
        end
    end
    
    chsV = zeros(1,24)|chs; % Assigns Movement to channel
    
    
    
    chIdxExtra = bitshift(sum(bitset(0,find(chsV==1))),-16);
    chIdxUpper = bitshift(sum(bitset(0,find(chsV==1))),-8);
    chIdxUpper = bitand(chIdxUpper,255);
    chIdxLower = bitand(sum(bitset(0,find(chsV==1))),255);
    nCh = size(find(chsV==1),2);
    
    if nCh == 0
        set(handles.t_msg,'String','Please select channels');   
        return;
    end
        
    
    resetValues = get(handles.cb_reset,'Value');    
    if resetValues
        for i = 1 : 9
            movs{i}.motorThresh = 0;
            movs{i}.mvcLevel = 0;
            movs{i}.data = 0;
            set(eval(strcat('handles.et_MVC',num2str(i))),'String','');
            set(eval(strcat('handles.et_thresh',num2str(i))),'String','');
            set(eval(strcat('handles.s_thresh',num2str(i))),'Value',0);
        end
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
    
    % Conversion from "seconds" to "number of Samples"
    samples = str2double(get(handles.et_time,'String'));
    samples = samples/((tWs-oWs)/sF);
    
    
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
    obj.InputBufferSize = 4*24*samples*1000;

    % Open the connection
    fopen(obj);
    % Read available data and discard it
    if obj.BytesAvailable > 0
        fread(obj,obj.BytesAvailable,'uint8');    % Read the samples        
    end    

    pause(0.5);
    
    featureTime = (tWs-oWs)/sF;
    maxCount = round((1/featureTime)/2);
    if maxCount < 1
        maxCount = 1;
    end
    refreshBarsCount = 0;

    % Start the features extraction
    fwrite(obj,'X','uint8');
    fwrite(obj,chIdxExtra,'uint8');
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
        acqData = fread(obj,(nFeatures*nCh),'float32');                              
        % update the MVC level
        chCount = 1;
        for j = 1 : 24
            if chs(j)~=0
                movs{chs(j)}.data(i) = acqData(chCount);
                if acqData(chCount) >= movs{chs(j)}.mvcLevel
                    movs{chs(j)}.mvcLevel = acqData(chCount);
                end
                chCount = chCount + 1;
            end
        end 
        refreshBarsCount = refreshBarsCount + 1;
        % get the plot routines faster
        if refreshBarsCount == maxCount
            UpdateBars(handles);   
            refreshBarsCount = 0;
        end
    end
    disp(toc)
    
    % Stop the aquisition
    fwrite(obj,'T','char');
    % Close connection
    fclose(obj);
    
    set(handles.t_msg,'String','Features Received');
    %fileName = sprintf('FeaturesThresholdCalibration_%s.mat', datestr(now,'yy-mm-dd_HH-MM'));
    fileName = 'FeaturesThresholdCalibration';
    save(fileName,'movs', 'featureTime', 'sF', 'nCh');
    
    % Update the GUI
    for i = 1 : 9
        if movs{i}.active
            message = num2str( movs{i}.mvcLevel);
            set(eval(strcat('handles.et_MVC',num2str(i))),'String',message);
            set(eval(strcat('handles.s_thresh',num2str(i))),'Max',movs{i}.mvcLevel,'Min',0,'SliderStep',[movs{i}.mvcLevel/100 movs{i}.mvcLevel/100]);
        end
    end
    drawnow;
    
    if(checkNoiseLevel)
        for i = 1 : 9      
            if movs{i}.active
                noiseLevel(i) = mean(movs{i}.data);
                set(eval(strcat('handles.s_thresh',num2str(i))),'Value',noiseLevel(i));
                newValue = get(eval(strcat('handles.s_thresh',num2str(i))),'Value');
                set(eval(strcat('handles.et_thresh',num2str(i))),'string',num2str( newValue));  
            end
        end   
    end
    
    % update plot for open hand channel recording
    if (movs{1}.active)
        recTime = samples*featureTime;
        axes(handles.ax_open)
        plot(linspace(0,recTime,samples),movs{1}.data)
        hold on
        handles.openLineMVC = plot(linspace(0,recTime,samples),ones(1,samples)*movs{1}.mvcLevel,'-r','LineWidth',2.5,'ButtonDownFcn', @(hObject,eventdata)GUI_SetDC_24chs('startDragOpenLineMVC_Fcn',hObject,eventdata,guidata(hObject)));
        handles.openLineThresh = plot(linspace(0,recTime,samples),ones(1,samples)*movs{1}.mvcLevel/2,'-b','LineWidth',2.5,'ButtonDownFcn',@(hObject,eventdata)GUI_SetDC_24chs('startDragOpenLineThresh_Fcn',hObject,eventdata,guidata(hObject)));
        hold off
    end
    
    % update plot for close hand channel recording
    if (movs{2}.active)
        recTime = samples*featureTime;
        axes(handles.ax_close)
        plot(linspace(0,recTime,samples),movs{2}.data)
        hold on
        handles.closeLineMVC = plot(linspace(0,recTime,samples),ones(1,samples)*movs{2}.mvcLevel,'-r','LineWidth',2.5,'ButtonDownFcn', @(hObject,eventdata)GUI_SetDC_24chs('startDragCloseLineMVC_Fcn',hObject,eventdata,guidata(hObject)));
        handles.closeLineThresh = plot(linspace(0,recTime,samples),ones(1,samples)*movs{2}.mvcLevel/2,'-b','LineWidth',2.5,'ButtonDownFcn',@(hObject,eventdata)GUI_SetDC_24chs('startDragCloseLineThresh_Fcn',hObject,eventdata,guidata(hObject)));
        hold off
    end
    
    % update plot for pronation channel recording
    if (movs{3}.active)
        recTime = samples*featureTime;
        axes(handles.ax_pronation)
        plot(linspace(0,recTime,samples),movs{3}.data)
        hold on
        handles.wristPronLineMVC = plot(linspace(0,recTime,samples),ones(1,samples)*movs{3}.mvcLevel,'-r','LineWidth',2.5,'ButtonDownFcn', @(hObject,eventdata)GUI_SetDC_24chs('startDragWristPronLineMVC_Fcn',hObject,eventdata,guidata(hObject)));
        handles.wristPronLineThresh = plot(linspace(0,recTime,samples),ones(1,samples)*movs{3}.mvcLevel/2,'-b','LineWidth',2.5,'ButtonDownFcn',@(hObject,eventdata)GUI_SetDC_24chs('startDragWristPronLineThresh_Fcn',hObject,eventdata,guidata(hObject)));
        hold off
    end
    % update plot for Supination channel recording
     if (movs{4}.active)
        recTime = samples*featureTime;
        axes(handles.ax_supination)
        plot(linspace(0,recTime,samples),movs{4}.data)
        hold on
        handles.wristSupLineMVC = plot(linspace(0,recTime,samples),ones(1,samples)*movs{4}.mvcLevel,'-r','LineWidth',2.5,'ButtonDownFcn', @(hObject,eventdata)GUI_SetDC_24chs('startDragWristSupLineMVC_Fcn',hObject,eventdata,guidata(hObject)));
        handles.wristSupLineThresh = plot(linspace(0,recTime,samples),ones(1,samples)*movs{4}.mvcLevel/2,'-b','LineWidth',2.5,'ButtonDownFcn',@(hObject,eventdata)GUI_SetDC_24chs('startDragWristSupLineThresh_Fcn',hObject,eventdata,guidata(hObject)));
        hold off
     end
    % update plot for elbow flexion channel recording
     if (movs{7}.active)
        recTime = samples*featureTime;
        axes(handles.ax_elbowflex)
        plot(linspace(0,recTime,samples),movs{7}.data)
        hold on
        handles.elbowFlexLineMVC = plot(linspace(0,recTime,samples),ones(1,samples)*movs{7}.mvcLevel,'-r','LineWidth',2.5,'ButtonDownFcn', @(hObject,eventdata)GUI_SetDC_24chs('startDragElbowFlexLineMVC_Fcn',hObject,eventdata,guidata(hObject)));
        handles.elbowFlexLineThresh = plot(linspace(0,recTime,samples),ones(1,samples)*movs{7}.mvcLevel/2,'-b','LineWidth',2.5,'ButtonDownFcn',@(hObject,eventdata)GUI_SetDC_24chs('startDragElbowFlexLineThresh_Fcn',hObject,eventdata,guidata(hObject)));
        hold off
     end
    
     % update plot for elbow extension channel recording
     if (movs{8}.active)
        recTime = samples*featureTime;
        axes(handles.ax_elbowextend)
        plot(linspace(0,recTime,samples),movs{8}.data)
        hold on
        handles.elbowExtendLineMVC = plot(linspace(0,recTime,samples),ones(1,samples)*movs{8}.mvcLevel,'-r','LineWidth',2.5,'ButtonDownFcn', @(hObject,eventdata)GUI_SetDC_24chs('startDragElbowExtendLineMVC_Fcn',hObject,eventdata,guidata(hObject)));
        handles.elbowExtendLineThresh = plot(linspace(0,recTime,samples),ones(1,samples)*movs{8}.mvcLevel/2,'-b','LineWidth',2.5,'ButtonDownFcn',@(hObject,eventdata)GUI_SetDC_24chs('startDragElbowExtendLineThresh_Fcn',hObject,eventdata,guidata(hObject)));
        hold off
     end
    
    % update plot for switch hand channel recording
    if (movs{9}.active)
        recTime = samples*featureTime;
        axes(handles.ax_ramp)
        plot(linspace(0,recTime,samples),movs{9}.data)
        hold on
        handles.switchLineMVC = plot(linspace(0,recTime,samples),ones(1,samples)*movs{9}.mvcLevel,'-r','LineWidth',2.5,'ButtonDownFcn', @(hObject,eventdata)GUI_SetDC_24chs('startDragSwitchLineMVC_Fcn',hObject,eventdata,guidata(hObject)));
        handles.switchLineThresh = plot(linspace(0,recTime,samples),ones(1,samples)*movs{9}.mvcLevel/2,'-b','LineWidth',2.5,'ButtonDownFcn',@(hObject,eventdata)GUI_SetDC_24chs('startDragSwitchLineThresh_Fcn',hObject,eventdata,guidata(hObject)));
        hold off
    end
    
    % Update handles structure
    guidata(hObject, handles);
    
    
%==========================================================================    
%% Code for dragable MVC and threshold lines
%==========================================================================
% Open hand
%--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function startDragOpenLineMVC_Fcn(hObject, eventdata, handles)
        set(handles.figure1, 'WindowButtonMotionFcn', @(hObject,eventdata)GUI_SetDC_24chs('draggingOpenLineMVC_Fcn',hObject,eventdata,guidata(hObject))); 
    
function draggingOpenLineMVC_Fcn(hObject, eventdata, handles)
        global movs;
        pt = get(handles.ax_open, 'CurrentPoint');
        set(handles.openLineMVC, 'YData', ones(1,length(get(handles.openLineThresh,'XData')))*pt(1,2)); 
        % update parameters for that channel according to new position of the line
        movs{1}.mvcLevel = pt(1,2);
        set(eval(strcat('handles.et_MVC',num2str(1))),'String',num2str( pt(1,2)));
        set(eval(strcat('handles.s_thresh',num2str(1))),'min',0);
        set(eval(strcat('handles.s_thresh',num2str(1))),'max',pt(1,2));
        
function startDragOpenLineThresh_Fcn(hObject, eventdata, handles)
        set(handles.figure1, 'WindowButtonMotionFcn', @(hObject,eventdata)GUI_SetDC_24chs('draggingOpenLineThresh_Fcn',hObject,eventdata,guidata(hObject))); 

function draggingOpenLineThresh_Fcn(hObject, eventdata, handles)
        global movs;
        pt = get(handles.ax_open, 'CurrentPoint');
        set(handles.openLineThresh, 'YData', ones(1,length(get(handles.openLineThresh,'XData')))*pt(1,2));
        % update parameters for that channel according to new position of the line
        movs{1}.motorThresh = pt(1,2);
        set(eval(strcat('handles.et_thresh',num2str(1))),'String',num2str( pt(1,2)));
        set(eval(strcat('handles.s_thresh',num2str(1))),'Value',pt(1,2)); 

% Close hand
%--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function startDragCloseLineMVC_Fcn(hObject, eventdata, handles)
        set(handles.figure1, 'WindowButtonMotionFcn', @(hObject,eventdata)GUI_SetDC_24chs('draggingCloseLineMVC_Fcn',hObject,eventdata,guidata(hObject))); 
    
function draggingCloseLineMVC_Fcn(hObject, eventdata, handles)
        global movs;
        pt = get(handles.ax_close, 'CurrentPoint');
        set(handles.closeLineMVC, 'YData', ones(1,length(get(handles.closeLineThresh,'XData')))*pt(1,2)); 
        % update parameters for that channel according to new position of the line
        movs{2}.mvcLevel = pt(1,2);
        set(eval(strcat('handles.et_MVC',num2str(2))),'String',num2str( pt(1,2)));
        set(eval(strcat('handles.s_thresh',num2str(2))),'min',0);
        set(eval(strcat('handles.s_thresh',num2str(2))),'max',pt(1,2));
        
function startDragCloseLineThresh_Fcn(hObject, eventdata, handles)
        set(handles.figure1, 'WindowButtonMotionFcn', @(hObject,eventdata)GUI_SetDC_24chs('draggingCloseLineThresh_Fcn',hObject,eventdata,guidata(hObject))); 
    
function draggingCloseLineThresh_Fcn(hObject, eventdata, handles)
        global movs;
        pt = get(handles.ax_close, 'CurrentPoint');
        set(handles.closeLineThresh, 'YData', ones(1,length(get(handles.closeLineThresh,'XData')))*pt(1,2));
        % update parameters for that channel according to new position of the line
        movs{2}.motorThresh = pt(1,2);
        set(eval(strcat('handles.et_thresh',num2str(2))),'String',num2str( pt(1,2)));
        set(eval(strcat('handles.s_thresh',num2str(2))),'Value',pt(1,2));        

% Wrist pronation
%--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function startDragWristPronLineMVC_Fcn(hObject, eventdata, handles)
        set(handles.figure1, 'WindowButtonMotionFcn', @(hObject,eventdata)GUI_SetDC_24chs('draggingWristPronLineMVC_Fcn',hObject,eventdata,guidata(hObject))); 
    
function draggingWristPronLineMVC_Fcn(hObject, eventdata, handles)
        global movs;
        pt = get(handles.ax_pronation, 'CurrentPoint');
        set(handles.wristPronLineMVC, 'YData', ones(1,length(get(handles.wristPronLineThresh,'XData')))*pt(1,2)); 
        % update parameters for that channel according to new position of the line
        selectedMovement = 3;
        movs{selectedMovement}.mvcLevel = pt(1,2);
        set(eval(strcat('handles.et_MVC',num2str(selectedMovement))),'String',num2str( pt(1,2)));
        set(eval(strcat('handles.s_thresh',num2str(selectedMovement))),'min',0);
        set(eval(strcat('handles.s_thresh',num2str(selectedMovement))),'max',pt(1,2));
        
function startDragWristPronLineThresh_Fcn(hObject, eventdata, handles)
        set(handles.figure1, 'WindowButtonMotionFcn', @(hObject,eventdata)GUI_SetDC_24chs('draggingWristPronLineThresh_Fcn',hObject,eventdata,guidata(hObject))); 
    
function draggingWristPronLineThresh_Fcn(hObject, eventdata, handles)
        global movs;
        pt = get(handles.ax_pronation, 'CurrentPoint');
        set(handles.wristPronLineThresh, 'YData', ones(1,length(get(handles.wristPronLineThresh,'XData')))*pt(1,2));
        % update parameters for that channel according to new position of the line
        selectedMovement = 3;
        movs{selectedMovement}.motorThresh = pt(1,2);
        set(eval(strcat('handles.et_thresh',num2str(selectedMovement))),'String',num2str( pt(1,2)));
        set(eval(strcat('handles.s_thresh',num2str(selectedMovement))),'Value',pt(1,2));
 
 % Wrist Supination
%--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function startDragWristSupLineMVC_Fcn(hObject, eventdata, handles)
        set(handles.figure1, 'WindowButtonMotionFcn', @(hObject,eventdata)GUI_SetDC_24chs('draggingWristSupLineMVC_Fcn',hObject,eventdata,guidata(hObject))); 
    
function draggingWristSupLineMVC_Fcn(hObject, eventdata, handles)
        global movs;
        pt = get(handles.ax_supination, 'CurrentPoint');
        set(handles.wristSupLineMVC, 'YData', ones(1,length(get(handles.wristSupLineThresh,'XData')))*pt(1,2)); 
        % update parameters for that channel according to new position of the line
        selectedMovement = 4;
        movs{selectedMovement}.mvcLevel = pt(1,2);
        set(eval(strcat('handles.et_MVC',num2str(selectedMovement))),'String',num2str( pt(1,2)));
        set(eval(strcat('handles.s_thresh',num2str(selectedMovement))),'min',0);
        set(eval(strcat('handles.s_thresh',num2str(selectedMovement))),'max',pt(1,2));
        
function startDragWristSupLineThresh_Fcn(hObject, eventdata, handles)
        set(handles.figure1, 'WindowButtonMotionFcn', @(hObject,eventdata)GUI_SetDC_24chs('draggingWristSupLineThresh_Fcn',hObject,eventdata,guidata(hObject))); 
    
function draggingWristSupLineThresh_Fcn(hObject, eventdata, handles)
        global movs;
        pt = get(handles.ax_supination, 'CurrentPoint');
        set(handles.wristSupLineThresh, 'YData', ones(1,length(get(handles.wristSupLineThresh,'XData')))*pt(1,2));
        % update parameters for that channel according to new position of the line
        selectedMovement = 4;
        movs{selectedMovement}.motorThresh = pt(1,2);
        set(eval(strcat('handles.et_thresh',num2str(selectedMovement))),'String',num2str( pt(1,2)));
        set(eval(strcat('handles.s_thresh',num2str(selectedMovement))),'Value',pt(1,2));

% Elbow Flexion
%--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function startDragElbowFlexLineMVC_Fcn(hObject, eventdata, handles)
        set(handles.figure1, 'WindowButtonMotionFcn', @(hObject,eventdata)GUI_SetDC_24chs('draggingElbowFlexLineMVC_Fcn',hObject,eventdata,guidata(hObject))); 
    
function draggingElbowFlexLineMVC_Fcn(hObject, eventdata, handles)
        global movs;
        pt = get(handles.ax_elbowflex, 'CurrentPoint');
        set(handles.elbowFlexLineMVC, 'YData', ones(1,length(get(handles.elbowFlexLineThresh,'XData')))*pt(1,2)); 
        % update parameters for that channel according to new position of the line
        selectedMovement = 7;
        movs{selectedMovement}.mvcLevel = pt(1,2);
        set(eval(strcat('handles.et_MVC',num2str(selectedMovement))),'String',num2str( pt(1,2)));
        set(eval(strcat('handles.s_thresh',num2str(selectedMovement))),'min',0);
        set(eval(strcat('handles.s_thresh',num2str(selectedMovement))),'max',pt(1,2));
        
function startDragElbowFlexLineThresh_Fcn(hObject, eventdata, handles)
        set(handles.figure1, 'WindowButtonMotionFcn', @(hObject,eventdata)GUI_SetDC_24chs('draggingElbowFlexLineThresh_Fcn',hObject,eventdata,guidata(hObject))); 
    
function draggingElbowFlexLineThresh_Fcn(hObject, eventdata, handles)
        global movs;
        pt = get(handles.ax_elbowflex, 'CurrentPoint');
        set(handles.elbowFlexLineThresh, 'YData', ones(1,length(get(handles.elbowFlexLineThresh,'XData')))*pt(1,2));
        % update parameters for that channel according to new position of the line
        selectedMovement = 7;
        movs{selectedMovement}.motorThresh = pt(1,2);
        set(eval(strcat('handles.et_thresh',num2str(selectedMovement))),'String',num2str( pt(1,2)));
        set(eval(strcat('handles.s_thresh',num2str(selectedMovement))),'Value',pt(1,2));
        
 % Elbow Extend
%--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function startDragElbowExtendLineMVC_Fcn(hObject, eventdata, handles)
        set(handles.figure1, 'WindowButtonMotionFcn', @(hObject,eventdata)GUI_SetDC_24chs('draggingElbowExtendLineMVC_Fcn',hObject,eventdata,guidata(hObject))); 
    
function draggingElbowExtendLineMVC_Fcn(hObject, eventdata, handles)
        global movs;
        pt = get(handles.ax_elbowextend, 'CurrentPoint');
        set(handles.elbowExtendLineMVC, 'YData', ones(1,length(get(handles.elbowExtendLineThresh,'XData')))*pt(1,2)); 
        % update parameters for that channel according to new position of the line
        selectedMovement = 8;
        movs{selectedMovement}.mvcLevel = pt(1,2);
        set(eval(strcat('handles.et_MVC',num2str(selectedMovement))),'String',num2str( pt(1,2)));
        set(eval(strcat('handles.s_thresh',num2str(selectedMovement))),'min',0);
        set(eval(strcat('handles.s_thresh',num2str(selectedMovement))),'max',pt(1,2));
        
function startDragElbowExtendLineThresh_Fcn(hObject, eventdata, handles)
        set(handles.figure1, 'WindowButtonMotionFcn', @(hObject,eventdata)GUI_SetDC_24chs('draggingElbowExtendLineThresh_Fcn',hObject,eventdata,guidata(hObject))); 
    
function draggingElbowExtendLineThresh_Fcn(hObject, eventdata, handles)
        global movs;
        pt = get(handles.ax_elbowextend, 'CurrentPoint');
        set(handles.elbowExtendLineThresh, 'YData', ones(1,length(get(handles.elbowExtendLineThresh,'XData')))*pt(1,2));
        % update parameters for that channel according to new position of the line
        selectedMovement = 8;
        movs{selectedMovement}.motorThresh = pt(1,2);
        set(eval(strcat('handles.et_thresh',num2str(selectedMovement))),'String',num2str( pt(1,2)));
        set(eval(strcat('handles.s_thresh',num2str(selectedMovement))),'Value',pt(1,2));
        
        
% Switch
%--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function startDragSwitchLineMVC_Fcn(hObject, eventdata, handles)
        set(handles.figure1, 'WindowButtonMotionFcn', @(hObject,eventdata)GUI_SetDC_24chs('draggingSwitchLineMVC_Fcn',hObject,eventdata,guidata(hObject))); 
    
function draggingSwitchLineMVC_Fcn(hObject, eventdata, handles)
        global movs;
        pt = get(handles.ax_ramp, 'CurrentPoint');
        set(handles.switchLineMVC, 'YData', ones(1,length(get(handles.switchLineThresh,'XData')))*pt(1,2)); 
        % update parameters for that channel according to new position of the line
        movs{9}.mvcLevel = pt(1,2);
        set(eval(strcat('handles.et_MVC',num2str(9))),'String',num2str( pt(1,2)));
        set(eval(strcat('handles.s_thresh',num2str(9))),'min',0);
        set(eval(strcat('handles.s_thresh',num2str(9))),'max',pt(1,2));
        
function startDragSwitchLineThresh_Fcn(hObject, eventdata, handles)
        set(handles.figure1, 'WindowButtonMotionFcn', @(hObject,eventdata)GUI_SetDC_24chs('draggingSwitchLineThresh_Fcn',hObject,eventdata,guidata(hObject))); 
    
function draggingSwitchLineThresh_Fcn(hObject, eventdata, handles)
        global movs;
        pt = get(handles.ax_ramp, 'CurrentPoint');
        set(handles.switchLineThresh, 'YData', ones(1,length(get(handles.switchLineThresh,'XData')))*pt(1,2));
        % update parameters for that channel according to new position of the line
        movs{9}.motorThresh = pt(1,2);
        set(eval(strcat('handles.et_thresh',num2str(9))),'String',num2str( pt(1,2)));
        set(eval(strcat('handles.s_thresh',num2str(9))),'Value',pt(1,2));   
        
function stopDragFcn(hObject, eventdata, handles)
        set(handles.figure1, 'WindowButtonMotionFcn', '');
    
%==========================================================================    
%% Update bar handles
%==========================================================================                    
function UpdateBars(handles)    

    global movs;
    
    for j = 1 : 9
        if movs{j}.active
            if movs{j}.mvcLevel ~= 0
                set(eval(strcat('handles.p_',num2str(j))),'YLim',[0 movs{j}.mvcLevel]);
            end
            set(handles.p_t(j),'YData', movs{j}.data(end));
        end
    end
    drawnow expose

%==========================================================================    
%% Analog frontend
%==========================================================================
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
    if isfield(handles,'obj')
        set(handles.t_msg,'String','Already connected');
        return;
    end
    
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
newValue = num2str( newValue);
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
newValue = num2str( newValue);
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
newValue = num2str( newValue);
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
newValue = num2str( newValue);
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
newValue = num2str( newValue);
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
newValue = num2str( newValue);
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
newValue = num2str( newValue);
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
newValue = num2str( newValue);
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


% --- Executes on selection change in pm_selCh9.
function pm_selCh9_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selCh9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selCh9 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selCh9


% --- Executes during object creation, after setting all properties.
function pm_selCh9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selCh9 (see GCBO)
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
newValue = num2str( newValue);
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


% --------------------------------------------------------------------
% ALC-D tab -> Load settings from file
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
    
    % Update the GUI with movements information
    for j = 1:9
        if movs{j}.active
            set(eval(strcat('handles.et_MVC',num2str(j))),'String',num2str(movs{j}.mvcLevel));
            set(eval(strcat('handles.p_',num2str(j))),'YLim',[0 movs{j}.mvcLevel]);
            set(eval(strcat('handles.et_thresh',num2str(j))),'string',num2str( movs{j}.motorThresh));
            set(eval(strcat('handles.s_thresh',num2str(j))),'Max',movs{j}.mvcLevel,'Min',0);
            set(eval(strcat('handles.s_thresh',num2str(j))),'Value',movs{j}.motorThresh);
            set(eval(strcat('handles.pm_selCh',num2str(j))),'Value',movs{j}.chAcqIndex+1);
        else
            set(eval(strcat('handles.et_MVC',num2str(j))),'String','');
            set(eval(strcat('handles.et_thresh',num2str(j))),'String','');
            set(eval(strcat('handles.s_thresh',num2str(j))),'Value',0);
            set(eval(strcat('handles.pm_selCh',num2str(j))),'Value',1);
        end
        
    end
    % co-contraction
    if movs{10}.active
        set(handles.cb_cocEnable,'Value',1);
        set(handles.et_cocontractOpen,'string',num2str( movs{10}.thresh1));
        set(handles.et_cocontractClose,'string',num2str( movs{10}.thresh2));
    else
        set(handles.cb_cocEnable,'Value',0);
    end
    
    % update plot for open hand channel recording
    if (movs{1}.active) && (isempty(movs{1}.data) == 0)
        answer = questdlg('Data is present for open hand movement. Do you want to plot it?');
        if strcmp(answer,'Yes')
            recTime = samples*featureTime;
            axes(handles.ax_open)
            plot(linspace(0,recTime,samples),movs{1}.data)
            hold on
            handles.openLineMVC = plot(linspace(0,recTime,samples),ones(1,samples)*movs{1}.mvcLevel,'-r','LineWidth',2.5,'ButtonDownFcn', @(hObject,eventdata)GUI_SetDC_24chs('startDragOpenLineMVC_Fcn',hObject,eventdata,guidata(hObject)));
            handles.openLineThresh = plot(linspace(0,recTime,samples),ones(1,samples)*movs{1}.mvcLevel/2,'-b','LineWidth',2.5,'ButtonDownFcn',@(hObject,eventdata)GUI_SetDC_24chs('startDragOpenLineThresh_Fcn',hObject,eventdata,guidata(hObject)));
            hold off
        end
    end
    
    % update plot for close hand channel recording
    if (movs{2}.active) && (isempty(movs{2}.data) == 0)
        answer = questdlg('Data is present for close hand movement. Do you want to plot it?');
        if strcmp(answer,'Yes')
            recTime = samples*featureTime;
            axes(handles.ax_close)
            plot(linspace(0,recTime,samples),movs{2}.data)
            hold on
            handles.closeLineMVC = plot(linspace(0,recTime,samples),ones(1,samples)*movs{2}.mvcLevel,'-r','LineWidth',2.5,'ButtonDownFcn', @(hObject,eventdata)GUI_SetDC_24chs('startDragCloseLineMVC_Fcn',hObject,eventdata,guidata(hObject)));
            handles.closeLineThresh = plot(linspace(0,recTime,samples),ones(1,samples)*movs{2}.mvcLevel/2,'-b','LineWidth',2.5,'ButtonDownFcn',@(hObject,eventdata)GUI_SetDC_24chs('startDragCloseLineThresh_Fcn',hObject,eventdata,guidata(hObject)));
            hold off
        end
    end
    
    % update plot for close hand channel recording
    if (movs{9}.active) && (isempty(movs{9}.data) == 0)
        answer = questdlg('Data is present for switch movement. Do you want to plot it?');
        if strcmp(answer,'Yes')
            recTime = samples*featureTime;
            axes(handles.ax_ramp)
            plot(linspace(0,recTime,samples),movs{9}.data)
            hold on
            handles.switchLineMVC = plot(linspace(0,recTime,samples),ones(1,samples)*movs{9}.mvcLevel,'-r','LineWidth',2.5,'ButtonDownFcn', @(hObject,eventdata)GUI_SetDC_24chs('startDragSwitchLineMVC_Fcn',hObject,eventdata,guidata(hObject)));
            handles.switchLineThresh = plot(linspace(0,recTime,samples),ones(1,samples)*movs{9}.mvcLevel/2,'-b','LineWidth',2.5,'ButtonDownFcn',@(hObject,eventdata)GUI_SetDC_24chs('startDragSwitchLineThresh_Fcn',hObject,eventdata,guidata(hObject)));
            hold off
        end
    end


% --------------------------------------------------------------------
% Thresholds Calibration tab -> Load Ramp track
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
    
    errorInCode = 1;
    if errorInCode
        status = sprintf('This function is currently unavailable');
        msgbox(status,'NCALfit')
        return;
    end
    
    % Selected channels
    chs = [];
    % ERROR: handles.cb not found -> probably from old SetDC. 
    % The new one has handles.pm_selCh
    for i = 1 : 16
        chs(i) = get(eval(strcat('handles.cb_',num2str(i))),'Value');
    end
    
    
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
    acqData = fread(obj,(nFeatures*nCh),'float32');
    acqData = fread(obj,(nFeatures*nCh),'float32');
    acqData = fread(obj,(nFeatures*nCh),'float32');    
    featureTime = (tWs-oWs)/sF;
    maxCount = (1/featureTime)/5;
    refreshBarsCount = 0;
    for i = 1:samples
        % (4bytes X features X nCh channels)
        acqData = fread(obj,(nFeatures*nCh),'float32');                             
        featuresNoise(i,:) = acqData; 
        % update the MVC level
        for j = 1 : nCh
            if acqData(j) > MVC(j)
                MVC(j) = acqData(j);
            end
        end 
        refreshBarsCount = refreshBarsCount+1;
        % get the plot routines faster
        if refreshBarsCount == maxCount
            UpdateBars(handles);   
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
            set(eval(strcat('handles.et_thresh',num2str(i))),'string',num2str( newValue));
            chCount = chCount + 1;
        end
    end
    % Update the GUI
    for i = 1 : 16
        if chs(i) 
            message = num2str( MVC(i));
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
    acqData = fread(obj,(nFeatures*nCh),'float32');
    acqData = fread(obj,(nFeatures*nCh),'float32');
    acqData = fread(obj,(nFeatures*nCh),'float32');    
    featureTime = (tWs-oWs)/sF;
    maxCount = (1/featureTime)/5;
    refreshBarsCount = 0;
    for i = 1:samples
        % (4bytes X features X nCh channels)
        acqData = fread(obj,(nFeatures*nCh),'float32');                             
        featuresOpen(i,:) = acqData; 
        % update the MVC level
        chCount = 1;
        for j = 1 : 16
            if chs(j)
                if acqData(chCount) > MVC(j)
                    MVC(j) = acqData(chCount);
                end
                chCount = chCount + 1;
            end
        end
        refreshBarsCount = refreshBarsCount+1;
        % get the plot routines faster
        if refreshBarsCount == maxCount
            UpdateBars(handles);   
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
                set(eval(strcat('handles.et_thresh',num2str(i))),'string',num2str( newValue));
            end
            chCount = chCount + 1;
        end
    end
    % Update the GUI
    for i = 1 : 16
        if chs(i) 
            message = num2str( MVC(i));
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
    acqData = fread(obj,(nFeatures*nCh),'float32');
    acqData = fread(obj,(nFeatures*nCh),'float32');
    acqData = fread(obj,(nFeatures*nCh),'float32');    
    featureTime = (tWs-oWs)/sF;
    maxCount = (1/featureTime)/5;
    refreshBarsCount = 0;
    for i = 1:samples
        % (4bytes X features X nCh channels)
        acqData = fread(obj,(nFeatures*nCh),'float32');                             
        featuresClose(i,:) = acqData; 
        % update the MVC level
        chCount = 1;
        for j = 1 : 16
            if chs(j)
                if acqData(chCount) > MVC(j)
                    MVC(j) = acqData(chCount);
                end
                chCount = chCount + 1;
            end
        end
        refreshBarsCount = refreshBarsCount+1;
        % get the plot routines faster
        if refreshBarsCount == maxCount
            UpdateBars(handles);   
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
                set(eval(strcat('handles.et_thresh',num2str(i))),'string',num2str( newValue));
            end
            chCount = chCount + 1;
        end
    end
    % Update the GUI
    for i = 1 : 16
        if chs(i) 
            message = num2str( MVC(i));
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
% Thresholds Calibration tab -> Channel range check
% Contains ERRORS
function menu_ramp_Callback(hObject, eventdata, handles)
% hObject    handle to menu_ramp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    global MVC;
    global chs;
    
    errorInCode = 1;
    if errorInCode
        status = sprintf('This function is currently unavailable');
        msgbox(status,'NCALfit')
        return;
    end

    set(handles.txt_ramp, 'Visible', 'on');
    % ERROR: handles.cb not found
    % Selected channels
    chs = [];
    for i = 1 : 16
        chs(i) = get(eval(strcat('handles.cb_',num2str(i))),'Value');
    end
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
    maxCount = round((1/featureTime)/recTime);
    
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
    acqData = fread(obj,(nFeatures*nCh),'float32');
    acqData = fread(obj,(nFeatures*nCh),'float32');
    acqData = fread(obj,(nFeatures*nCh),'float32');    
    refreshBarsCount = 0;
    for i = 1:samples
        % (4bytes X features X nCh channels)
        acqData = fread(obj,(nFeatures*nCh),'float32');                             
        featuresNoise(i,:) = acqData; 
        % update the MVC level
        chCount = 1;
        for j = 1 : 16
            if chs(j)
                if acqData(chCount) > MVC(j)
                    MVC(j) = acqData(chCount);
                end
                chCount = chCount + 1;
            end
        end 
        refreshBarsCount = refreshBarsCount+1;
        % get the plot routines faster
        if refreshBarsCount == maxCount
            UpdateBars(handles);   
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
            set(eval(strcat('handles.et_thresh',num2str(i))),'string',num2str( newValue));
            chCount = chCount + 1;
        end
    end
    % Update the GUI
    for i = 1 : 16
        if chs(i) 
            message = num2str( MVC(i));
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
    acqData = fread(obj,(nFeatures*nCh),'float32');
    acqData = fread(obj,(nFeatures*nCh),'float32');
    acqData = fread(obj,(nFeatures*nCh),'float32');    
    refreshBarsCount = 0;
    for i = 1:samples
        % (4bytes X features X nCh channels)
        acqData = fread(obj,(nFeatures*nCh),'float32');                             
        featuresOpen(i,:) = acqData; 
        % update the MVC level
        chCount = 1;
        for j = 1 : 16
            if chs(j)
                if acqData(chCount) > MVC(j)
                    MVC(j) = acqData(chCount);
                end
                chCount = chCount + 1;
            end
        end 
        refreshBarsCount = refreshBarsCount+1;
        % get the plot routines faster
        if refreshBarsCount == maxCount
            UpdateBars(handles);   
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
            acqDataOpen = chCount;
        end
    end
    % Update the GUI for open hand channel
    message = num2str( MVC(openHandChannel));
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
    acqData = fread(obj,(nFeatures*nCh),'float32');
    acqData = fread(obj,(nFeatures*nCh),'float32');
    acqData = fread(obj,(nFeatures*nCh),'float32');    
    refreshBarsCount = 0;
    for i = 1:samples
        acqData = fread(obj,(nFeatures*nCh),'float32');                             
        featuresClose(i,:) = acqData; 
        % update the MVC level
        chCount = 1;
        for j = 1 : 16
            if chs(j)
                if acqData(chCount) > MVC(j)
                    MVC(j) = acqData(chCount);
                end
                chCount = chCount + 1;
            end
        end 
        refreshBarsCount = refreshBarsCount+1;
        % get the plot routines faster
        if refreshBarsCount == maxCount
            UpdateBars(handles);   
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
            acqDataClose = chCount;
        end
    end
    % Update the GUI for close hand channel
    message = num2str( MVC(closeHandChannel));
    set(eval(strcat('handles.et_MVC',num2str(closeHandChannel))),'String',message);
    drawnow;
    
    % setup ramp recording 
    if (acqDataOpen == 0) || (acqDataClose == 0)
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
    acqData = fread(obj,(nFeatures*nCh),'float32');
    acqData = fread(obj,(nFeatures*nCh),'float32');
    acqData = fread(obj,(nFeatures*nCh),'float32');  
    refreshBarsCount = 0;
    tic
    for i = 1:samples
        acqData = fread(obj,(nFeatures*nCh),'float32');                             
        rampOpen(i,:) = acqData; 
        effortRatio = 100*(abs(acqData(acqDataOpen)-noiseLevel(acqDataOpen))/(openHandMVC-noiseLevel(acqDataOpen)));
        if effortRatio > 100
            effortRatio = 100;
        end
        refreshBarsCount = refreshBarsCount+1;
        % get the plot routines faster
        if refreshBarsCount == maxCount
            UpdateBars(handles); 
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
    acqData = fread(obj,(nFeatures*nCh),'float32');
    acqData = fread(obj,(nFeatures*nCh),'float32');
    acqData = fread(obj,(nFeatures*nCh),'float32');    
    refreshBarsCount = 0;
    tic
    for i = 1:samples
        acqData = fread(obj,(nFeatures*nCh),'float32');                             
        rampClose(i,:) = acqData; 
        effortRatio = 100*(abs(acqData(acqDataClose)-noiseLevel(acqDataClose))/(closeHandMVC-noiseLevel(acqDataClose)));
        if effortRatio > 100
            effortRatio = 100;
        end
        refreshBarsCount = refreshBarsCount+1;
        % get the plot routines faster
        if refreshBarsCount == maxCount
            UpdateBars(handles); 
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
    plot(linspace(0,recTime,samples),rampOpen(:,acqDataOpen))
    hold on
    handles.openLineMVC = plot(linspace(0,recTime,samples),ones(1,samples)*openHandMVC,'-r','LineWidth',2.5,'ButtonDownFcn', @(hObject,eventdata)GUI_SetDC_24chs('startDragOpenLineMVC_Fcn',hObject,eventdata,guidata(hObject)));
    plot(linspace(0,recTime,samples),ones(1,samples)*noiseLevel(acqDataOpen),'g');
    handles.openLineThresh = plot(linspace(0,recTime,samples),ones(1,samples)*openHandMVC/2,'-b','LineWidth',2.5,'ButtonDownFcn',@(hObject,eventdata)GUI_SetDC_24chs('startDragOpenLineThresh_Fcn',hObject,eventdata,guidata(hObject)));
    hold off
    axes(handles.ax_close)
    plot(linspace(0,recTime,samples),rampClose(:,acqDataClose))
    hold on
    handles.closeLineMVC = plot(linspace(0,recTime,samples),ones(1,samples)*closeHandMVC,'-r','LineWidth',2.5,'ButtonDownFcn', @(hObject,eventdata)GUI_SetDC_24chs('startDragCloseLineMVC_Fcn',hObject,eventdata,guidata(hObject)));
    plot(linspace(0,recTime,samples),ones(1,samples)*noiseLevel(acqDataClose),'g');
    handles.closeLineThresh = plot(linspace(0,recTime,samples),ones(1,samples)*closeHandMVC/2,'-b','LineWidth',2.5,'ButtonDownFcn',@(hObject,eventdata)GUI_SetDC_24chs('startDragCloseLineThresh_Fcn',hObject,eventdata,guidata(hObject)));
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
            acqDataOpen = counter;
        end
        if i == closeHandChannel
            acqDataClose = counter;
        end
    end
    
    % Update the GUI
    for i = 1 : 16
        if chs(i) && (i==openHandChannel)
            message = num2str( openHandMVC);
            set(eval(strcat('handles.et_MVC',num2str(i))),'String',message);
            set(eval(strcat('handles.s_thresh',num2str(i))),'Max',openHandMVC,'Min',0,'SliderStep',[openHandMVC/100 openHandMVC/100]);
            set(eval(strcat('handles.pm_selMov',num2str(i))),'Value',2);
            set(eval(strcat('handles.cb_',num2str(i))),'Value',1);
        elseif chs(i) && (i==closeHandChannel)
            message = num2str( closeHandMVC);
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
    plot(linspace(0,recTime,samples),rampOpen(:,acqDataOpen))
    hold on
    handles.openLineMVC = plot(linspace(0,recTime,samples),ones(1,samples)*openHandMVC,'-r','LineWidth',2.5,'ButtonDownFcn', @(hObject,eventdata)GUI_SetDC_24chs('startDragOpenLineMVC_Fcn',hObject,eventdata,guidata(hObject)));
    plot(linspace(0,recTime,samples),ones(1,samples)*noiseLevel(acqDataOpen),'g');
    handles.openLineThresh = plot(linspace(0,recTime,samples),ones(1,samples)*openHandMVC/2,'-b','LineWidth',2.5,'ButtonDownFcn',@(hObject,eventdata)GUI_SetDC_24chs('startDragOpenLineThresh_Fcn',hObject,eventdata,guidata(hObject)));
    hold off
    axes(handles.ax_close)
    plot(linspace(0,recTime,samples),rampClose(:,acqDataClose))
    hold on
    handles.closeLineMVC = plot(linspace(0,recTime,samples),ones(1,samples)*closeHandMVC,'-r','LineWidth',2.5,'ButtonDownFcn', @(hObject,eventdata)GUI_SetDC_24chs('startDragCloseLineMVC_Fcn',hObject,eventdata,guidata(hObject)));
    plot(linspace(0,recTime,samples),ones(1,samples)*noiseLevel(acqDataClose),'g');
    handles.closeLineThresh = plot(linspace(0,recTime,samples),ones(1,samples)*closeHandMVC/2,'-b','LineWidth',2.5,'ButtonDownFcn',@(hObject,eventdata)GUI_SetDC_24chs('startDragCloseLineThresh_Fcn',hObject,eventdata,guidata(hObject)));
    hold off
    
    % Update handles structure
    guidata(hObject, handles);


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


% --- Executes on selection change in pm_selCh9.
function popupmenu15_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selCh9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selCh9 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selCh9


% --- Executes during object creation, after setting all properties.
function popupmenu15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selCh9 (see GCBO)
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


% --------------------------------------------------------------------
function menu_info_Callback(hObject, eventdata, handles)
% hObject    handle to menu_info (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msg = {'1) select the target movements and the intended channels to be used for those movements', '2) check range of channels with automatic procedure', ...
    '3) run ramp track recording', '4) adjust the thresholds for open and close dragging the MVC and THRESH lines', '5) write the settings on the system and test it', ...
    '6) reiterate this process untill you find an optimal result'};
helpdlg(msg,'fitting procedure')



function edit94_Callback(hObject, eventdata, handles)
% hObject    handle to et_MVC9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_MVC9 as text
%        str2double(get(hObject,'String')) returns contents of et_MVC9 as a double


% --- Executes during object creation, after setting all properties.
function edit94_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_MVC9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_selCh9.
function popupmenu49_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selCh9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selCh9 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selCh9


% --- Executes during object creation, after setting all properties.
function popupmenu49_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selCh9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit95_Callback(hObject, eventdata, handles)
% hObject    handle to et_thresh9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_thresh9 as text
%        str2double(get(hObject,'String')) returns contents of et_thresh9 as a double


% --- Executes during object creation, after setting all properties.
function edit95_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_thresh9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider45_Callback(hObject, eventdata, handles)
% hObject    handle to s_thresh9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider45_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_thresh9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit92_Callback(hObject, eventdata, handles)
% hObject    handle to et_MVC8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_MVC8 as text
%        str2double(get(hObject,'String')) returns contents of et_MVC8 as a double


% --- Executes during object creation, after setting all properties.
function edit92_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_MVC8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_selCh8.
function popupmenu48_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selCh8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selCh8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selCh8


% --- Executes during object creation, after setting all properties.
function popupmenu48_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selCh8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit93_Callback(hObject, eventdata, handles)
% hObject    handle to et_thresh8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_thresh8 as text
%        str2double(get(hObject,'String')) returns contents of et_thresh8 as a double


% --- Executes during object creation, after setting all properties.
function edit93_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_thresh8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider44_Callback(hObject, eventdata, handles)
% hObject    handle to s_thresh8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider44_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_thresh8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit90_Callback(hObject, eventdata, handles)
% hObject    handle to et_MVC4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_MVC4 as text
%        str2double(get(hObject,'String')) returns contents of et_MVC4 as a double


% --- Executes during object creation, after setting all properties.
function edit90_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_MVC4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_selCh4.
function popupmenu47_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selCh4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selCh4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selCh4


% --- Executes during object creation, after setting all properties.
function popupmenu47_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selCh4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit91_Callback(hObject, eventdata, handles)
% hObject    handle to et_thresh4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_thresh4 as text
%        str2double(get(hObject,'String')) returns contents of et_thresh4 as a double


% --- Executes during object creation, after setting all properties.
function edit91_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_thresh4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider43_Callback(hObject, eventdata, handles)
% hObject    handle to s_thresh4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider43_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_thresh4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit88_Callback(hObject, eventdata, handles)
% hObject    handle to et_MVC7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_MVC7 as text
%        str2double(get(hObject,'String')) returns contents of et_MVC7 as a double


% --- Executes during object creation, after setting all properties.
function edit88_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_MVC7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_selCh7.
function popupmenu46_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selCh7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selCh7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selCh7


% --- Executes during object creation, after setting all properties.
function popupmenu46_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selCh7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit89_Callback(hObject, eventdata, handles)
% hObject    handle to et_thresh7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_thresh7 as text
%        str2double(get(hObject,'String')) returns contents of et_thresh7 as a double


% --- Executes during object creation, after setting all properties.
function edit89_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_thresh7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider42_Callback(hObject, eventdata, handles)
% hObject    handle to s_thresh7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider42_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_thresh7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit86_Callback(hObject, eventdata, handles)
% hObject    handle to et_MVC3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_MVC3 as text
%        str2double(get(hObject,'String')) returns contents of et_MVC3 as a double


% --- Executes during object creation, after setting all properties.
function edit86_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_MVC3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_selCh3.
function popupmenu45_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selCh3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selCh3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selCh3


% --- Executes during object creation, after setting all properties.
function popupmenu45_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selCh3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit87_Callback(hObject, eventdata, handles)
% hObject    handle to et_thresh3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_thresh3 as text
%        str2double(get(hObject,'String')) returns contents of et_thresh3 as a double


% --- Executes during object creation, after setting all properties.
function edit87_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_thresh3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider41_Callback(hObject, eventdata, handles)
% hObject    handle to s_thresh3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider41_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_thresh3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit84_Callback(hObject, eventdata, handles)
% hObject    handle to et_MVC5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_MVC5 as text
%        str2double(get(hObject,'String')) returns contents of et_MVC5 as a double


% --- Executes during object creation, after setting all properties.
function edit84_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_MVC5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit85_Callback(hObject, eventdata, handles)
% hObject    handle to et_thresh5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_thresh5 as text
%        str2double(get(hObject,'String')) returns contents of et_thresh5 as a double


% --- Executes during object creation, after setting all properties.
function edit85_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_thresh5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider40_Callback(hObject, eventdata, handles)
% hObject    handle to s_thresh5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider40_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_thresh5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in pm_selCh5.
function popupmenu44_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selCh5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selCh5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selCh5


% --- Executes during object creation, after setting all properties.
function popupmenu44_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selCh5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit82_Callback(hObject, eventdata, handles)
% hObject    handle to et_MVC6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_MVC6 as text
%        str2double(get(hObject,'String')) returns contents of et_MVC6 as a double


% --- Executes during object creation, after setting all properties.
function edit82_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_MVC6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_selCh6.
function popupmenu43_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selCh6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selCh6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selCh6


% --- Executes during object creation, after setting all properties.
function popupmenu43_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selCh6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit83_Callback(hObject, eventdata, handles)
% hObject    handle to et_thresh6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_thresh6 as text
%        str2double(get(hObject,'String')) returns contents of et_thresh6 as a double


% --- Executes during object creation, after setting all properties.
function edit83_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_thresh6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider39_Callback(hObject, eventdata, handles)
% hObject    handle to s_thresh6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider39_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_thresh6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit80_Callback(hObject, eventdata, handles)
% hObject    handle to et_MVC2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_MVC2 as text
%        str2double(get(hObject,'String')) returns contents of et_MVC2 as a double


% --- Executes during object creation, after setting all properties.
function edit80_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_MVC2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_selCh2.
function popupmenu42_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selCh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selCh2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selCh2


% --- Executes during object creation, after setting all properties.
function popupmenu42_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selCh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit81_Callback(hObject, eventdata, handles)
% hObject    handle to et_thresh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_thresh2 as text
%        str2double(get(hObject,'String')) returns contents of et_thresh2 as a double


% --- Executes during object creation, after setting all properties.
function edit81_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_thresh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider38_Callback(hObject, eventdata, handles)
% hObject    handle to s_thresh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider38_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_thresh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit78_Callback(hObject, eventdata, handles)
% hObject    handle to et_MVC1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_MVC1 as text
%        str2double(get(hObject,'String')) returns contents of et_MVC1 as a double


% --- Executes during object creation, after setting all properties.
function edit78_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_MVC1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_selCh1.
function popupmenu41_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selCh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selCh1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selCh1


% --- Executes during object creation, after setting all properties.
function popupmenu41_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selCh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit79_Callback(hObject, eventdata, handles)
% hObject    handle to et_thresh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_thresh1 as text
%        str2double(get(hObject,'String')) returns contents of et_thresh1 as a double


% --- Executes during object creation, after setting all properties.
function edit79_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_thresh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider37_Callback(hObject, eventdata, handles)
% hObject    handle to s_thresh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider37_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_thresh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function edit98_Callback(hObject, eventdata, handles)
% hObject    handle to edit98 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit98 as text
%        str2double(get(hObject,'String')) returns contents of edit98 as a double


% --- Executes during object creation, after setting all properties.
function edit98_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit98 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_selCh10.
function pm_selCh10_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selCh10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selCh10 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selCh10


% --- Executes during object creation, after setting all properties.
function pm_selCh10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selCh10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit99_Callback(hObject, eventdata, handles)
% hObject    handle to edit99 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit99 as text
%        str2double(get(hObject,'String')) returns contents of edit99 as a double


% --- Executes during object creation, after setting all properties.
function edit99_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit99 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider47_Callback(hObject, eventdata, handles)
% hObject    handle to slider47 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider47_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider47 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in pm_selCh11.
function pm_selCh11_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selCh11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selCh11 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selCh11


% --- Executes during object creation, after setting all properties.
function pm_selCh11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_selCh11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit100_Callback(hObject, eventdata, handles)
% hObject    handle to edit100 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit100 as text
%        str2double(get(hObject,'String')) returns contents of edit100 as a double


% --- Executes during object creation, after setting all properties.
function edit100_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit100 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit101_Callback(hObject, eventdata, handles)
% hObject    handle to edit101 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit101 as text
%        str2double(get(hObject,'String')) returns contents of edit101 as a double


% --- Executes during object creation, after setting all properties.
function edit101_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit101 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider48_Callback(hObject, eventdata, handles)
% hObject    handle to slider48 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider48_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider48 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



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


% --- Executes on selection change in pm_selExtraCh.
function pm_selExtraCh_Callback(hObject, eventdata, handles)
% hObject    handle to pm_selExtraCh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_selExtraCh contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_selExtraCh


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



function et_cocontractOpen_Callback(hObject, eventdata, handles)
% hObject    handle to et_cocontractOpen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_cocontractOpen as text
%        str2double(get(hObject,'String')) returns contents of et_cocontractOpen as a double


% --- Executes during object creation, after setting all properties.
function et_cocontractOpen_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_cocontractOpen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_cocontractClose_Callback(hObject, eventdata, handles)
% hObject    handle to et_cocontractClose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_cocontractClose as text
%        str2double(get(hObject,'String')) returns contents of et_cocontractClose as a double


% --- Executes during object creation, after setting all properties.
function et_cocontractClose_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_cocontractClose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cb_cocEnable.
function checkbox35_Callback(hObject, eventdata, handles)
% hObject    handle to cb_cocEnable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pb_write.
function pb_write_Callback(hObject, eventdata, handles)
% hObject    handle to pb_write (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global movs;

% Prepare information to send
nMovements = 0;
cocontractEnable = get(handles.cb_cocEnable,'Value');
for j = 1 : 9
    if get(eval(strcat('handles.pm_selCh',num2str(j))),'Value') ~= 1
        movs{j}.active = 1;
        movs{j}.chAcqIndex = get(eval(strcat('handles.pm_selCh',num2str(j))),'Value')-1;
        movs{j}.motorThresh = str2num(get(eval(strcat('handles.et_thresh',num2str(j))),'String'));
        movs{j}.mvcLevel = str2num(get(eval(strcat('handles.et_MVC',num2str(j))),'String'));
        nMovements = nMovements + 1;
        
        if isempty(movs{j}.motorThresh)
            set(handles.t_msg,'String','Set all motor thresholds');
            return;
        end
        
        if isempty(movs{j}.mvcLevel)
            set(handles.t_msg,'String','Set all MVC thresholds');
            return;
        end
            
    else
        movs{j}.active = 0;
        movs{j}.chAcqIndex = 0;
        movs{j}.motorThresh = 0;
        movs{j}.mvcLevel = 0;
        movs{j}.data = 0;
    end
end
if cocontractEnable
    movs{10}.active = 1;
    movs{10}.thresh1 = str2num(get(handles.et_cocontractOpen,'String'));
    movs{10}.thresh2 = str2num(get(handles.et_cocontractClose,'String'));
    nMovements = nMovements + 1;
    if isempty(movs{10}.thresh1)
        set(handles.t_msg,'String','Set all motor thresholds');
        return;
    end

    if isempty(movs{10}.thresh2)
        set(handles.t_msg,'String','Set all MVC thresholds');
        return;
    end
else
    movs{10}.active = 0;
    movs{10}.thresh1 = 0;
    movs{10}.thresh2 = 0;
end

if nMovements == 0
    set(handles.t_msg,'String','Select at least one channel');
    return;
end

% Update the movIndexes
movsLabels = get(handles.pm_mov1,'String');
for j=[1:4 7:9]
    if movs{j}.active
       if strcmp(movs{j}.name,movsLabels{get(eval(strcat('handles.pm_mov',num2str(j))),'Value')}) == 0
           movs{j}.name = movsLabels(get(eval(strcat('handles.pm_mov',num2str(j))),'Value'));
           switch(char(movs{j}.name))
               case 'open hand'
                   movs{j}.id = 1;
               case 'close hand'
                   movs{j}.id = 2;
               case 'pronation'
                   movs{j}.id = 4;
               case 'supination'
                   movs{j}.id = 8;
               case 'flex wrist'
                   movs{j}.id = 64;
               case 'extend wrist'
                   movs{j}.id = 128;
               case 'flex elbow'
                   movs{j}.id = 16;
               case 'extend elbow'
                   movs{j}.id = 32;
               case 'switch elbow'
                   movs{j}.id = 129;
               case 'switch next grasp'
                   movs{j}.id = 128;
               case 'switch to grasp1'
                   movs{j}.id = 132;
               case 'switch to grasp2'
                   movs{j}.id = 133;
               case 'switch to grasp3'
                   movs{j}.id = 134;
               case 'switch to grasp4'
                   movs{j}.id = 135;
               case 'switch to grasp5'
                   movs{j}.id = 136;
           end
       end
    end
end  

waitCocoTime = str2num(get(handles.et_waitCocoTime,'String'));

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
    % all regular movements first
    for j = 1:9
        if movs{j}.active
            fwrite(obj,movs{j}.active,'char');
            fwrite(obj,movs{j}.id,'char');
            fwrite(obj,movs{j}.chAcqIndex-1,'char');
            fwrite(obj,movs{j}.motorThresh,'float');
            fwrite(obj,movs{j}.mvcLevel,'float');
        end
    end
    % then cocontraction
    if movs{10}.active
        fwrite(obj,movs{10}.active,'char');
        fwrite(obj,movs{10}.id,'char');
        fwrite(obj,movs{10}.thresh1,'float');
        fwrite(obj,movs{10}.thresh2,'float');
        fwrite(obj,waitCocoTime,'char');
    end
    replay = char(fread(obj,1,'char'));
    set(handles.t_msg,'String','');
    pause(0.5)
    if strcmp(replay,'w')
        set(handles.t_msg,'String','Control settings correctly sent to ALC');
    else
        set(handles.t_msg,'String','Error sending Control settings');
        fclose(obj);
        return
    end
else
    set(handles.t_msg,'String','');
    pause(0.5)
    set(handles.t_msg,'String','Error sending Control settings');
    fclose(obj);
    return
end

fclose(obj);


% --- Executes on button press in pb_read.
function pb_read_Callback(hObject, eventdata, handles)
% hObject    handle to pb_read (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
global movs;

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
    
    % read settings for OPEN HAND and CLOSE HAND
    for i = 1:2
        movs{i}.active = fread(obj,1,'char');
        movs{i}.pwmOutput = fread(obj,1,'uint32');
        movs{i}.chAcqIndex = fread(obj,1,'char')+1;
        movs{i}.motorThresh = fread(obj,1,'float');
        movs{i}.mvcLevel = fread(obj,1,'float');
    end
    % read settings for SWITCH
    movs{9}.active = fread(obj,1,'char');
    movs{9}.pwmOutput = fread(obj,1,'uint32');
    movs{9}.chAcqIndex = fread(obj,1,'char')+1;
    movs{9}.motorThresh = fread(obj,1,'float');
    movs{9}.mvcLevel = fread(obj,1,'float');
    % read settings for AX_PRONATION, AX_SUPINATION, FLEX ELBOW and EXTEND ELBOW
    for i = [3 4 7 8]
        movs{i}.active = fread(obj,1,'char');
        movs{i}.pwmOutput = fread(obj,1,'uint32');
        movs{i}.chAcqIndex = fread(obj,1,'char')+1;
        movs{i}.motorThresh = fread(obj,1,'float');
        movs{i}.mvcLevel = fread(obj,1,'float');
    end
    % read settings for CO-CONTRACTION
    movs{10}.active = fread(obj,1,'char');
    movs{10}.pwmOutput = fread(obj,1,'uint32');
    movs{10}.thresh1 = fread(obj,1,'float');
    movs{10}.thresh2 = fread(obj,1,'float');
    waitCocoTime = fread(obj,1,'char');
    
    replay = char(fread(obj,1,'char'));
    set(handles.t_msg,'String','');
    pause(0.5)
    if strcmp(replay,'s')
        disp(obj)
        save('DCsettings.mat','movs');
        set(handles.t_msg,'String','Control settings read from ALC-D and saved into SETTINGS.mat file');
    else
        set(handles.t_msg,'String','Error Reading Control settings');
        fclose(obj);
        return
    end
else
    set(handles.t_msg,'String','');
    pause(0.5)
    set(handles.t_msg,'String','Error Reading Control settings');
    fclose(obj);
    return
end

fclose(obj);

% Update the GUI with movements information
for j = 1:9
    if movs{j}.active
        set(eval(strcat('handles.et_MVC',num2str(j))),'String',num2str(movs{j}.mvcLevel));
        set(eval(strcat('handles.p_',num2str(j))),'YLim',[0 movs{j}.mvcLevel]);
        set(eval(strcat('handles.et_thresh',num2str(j))),'string',num2str( movs{j}.motorThresh));
        set(eval(strcat('handles.s_thresh',num2str(j))),'Max',movs{j}.mvcLevel,'Min',0);
        set(eval(strcat('handles.s_thresh',num2str(j))),'Value',movs{j}.motorThresh);
        set(eval(strcat('handles.pm_selCh',num2str(j))),'Value',movs{j}.chAcqIndex+1);  
    else
        set(eval(strcat('handles.et_MVC',num2str(j))),'String','');
        set(eval(strcat('handles.et_thresh',num2str(j))),'String','');
        set(eval(strcat('handles.s_thresh',num2str(j))),'Value',0);
        set(eval(strcat('handles.pm_selCh',num2str(j))),'Value',1);
    end
    
end
% co-contraction
if movs{10}.active
    set(handles.cb_cocEnable,'Value',1);
    set(handles.et_cocontractOpen,'string',num2str( movs{10}.thresh1));
    set(handles.et_cocontractClose,'string',num2str( movs{10}.thresh2));
    set(handles.et_waitCocoTime,'string',num2str(waitCocoTime));
else
    set(handles.cb_cocEnable,'Value',0);
end


% --- Executes on selection change in pm_mov1.
function pm_mov1_Callback(hObject, eventdata, handles)
% hObject    handle to pm_mov1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_mov1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_mov1


% --- Executes during object creation, after setting all properties.
function pm_mov1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_mov1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_mov2.
function pm_mov2_Callback(hObject, eventdata, handles)
% hObject    handle to pm_mov2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_mov2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_mov2


% --- Executes during object creation, after setting all properties.
function pm_mov2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_mov2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_mov3.
function pm_mov3_Callback(hObject, eventdata, handles)
% hObject    handle to pm_mov3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_mov3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_mov3


% --- Executes during object creation, after setting all properties.
function pm_mov3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_mov3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_mov4.
function pm_mov4_Callback(hObject, eventdata, handles)
% hObject    handle to pm_mov4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_mov4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_mov4


% --- Executes during object creation, after setting all properties.
function pm_mov4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_mov4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_mov7.
function pm_mov7_Callback(hObject, eventdata, handles)
% hObject    handle to pm_mov7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_mov7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_mov7


% --- Executes during object creation, after setting all properties.
function pm_mov7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_mov7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_mov8.
function pm_mov8_Callback(hObject, eventdata, handles)
% hObject    handle to pm_mov8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_mov8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_mov8


% --- Executes during object creation, after setting all properties.
function pm_mov8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_mov8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_mov9.
function pm_mov9_Callback(hObject, eventdata, handles)
% hObject    handle to pm_mov9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_mov9 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_mov9


% --- Executes during object creation, after setting all properties.
function pm_mov9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_mov9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_waitCocoTime_Callback(hObject, eventdata, handles)
% hObject    handle to et_waitCocoTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_waitCocoTime as text
%        str2double(get(hObject,'String')) returns contents of et_waitCocoTime as a double


% --- Executes during object creation, after setting all properties.
function et_waitCocoTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_waitCocoTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
