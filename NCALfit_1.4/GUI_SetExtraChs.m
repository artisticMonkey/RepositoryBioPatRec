function varargout = GUI_SetExtraChs(varargin)
% GUI_PROSTHETICS MATLAB code for GUI_Prosthetics.fig
%      GUI_PROSTHETICS, by itself, creates a new GUI_PROSTHETICS or raises the existing
%      singleton*.
%
%      H = GUI_PROSTHETICS returns the handle to a new GUI_PROSTHETICS or the handle to
%      the existing singleton*.
%
%      GUI_PROSTHETICS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_PROSTHETICS.M with the given input arguments.
%
%      GUI_PROSTHETICS('Property','Value',...) creates a new GUI_PROSTHETICS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Prosthetics_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Prosthetics_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Prosthetics

% Last Modified by GUIDE v2.5 28-Nov-2018 19:27:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_SetExtraChs_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_SetExtraChs_OutputFcn, ...
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


% --- Executes just before GUI_Prosthetics is made visible.
function GUI_SetExtraChs_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Prosthetics (see VARARGIN)

% Choose default command line output for GUI_Prosthetics
handles.output = hObject;

% Take useful information from GUI father (if it exists)
if size(varargin,2) > 0
    oldHandles = varargin{1};
    if isfield(oldHandles,'obj')
        handles.obj = oldHandles.obj;
    end
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Prosthetics wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_SetExtraChs_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function et_Ch17_Ch1coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch17_Ch1coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch17_Ch1coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch17_Ch1coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch17_Ch1coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch17_Ch1coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function et_Ch18_Ch1coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch18_Ch1coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch18_Ch1coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch18_Ch1coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch18_Ch1coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch18_Ch1coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function et_Ch19_Ch1coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch19_Ch1coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch19_Ch1coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch19_Ch1coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch19_Ch1coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch19_Ch1coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function et_Ch20_Ch1coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch20_Ch1coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch20_Ch1coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch20_Ch1coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch20_Ch1coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch20_Ch1coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function et_Ch21_Ch1coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch21_Ch1coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch21_Ch1coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch21_Ch1coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch21_Ch1coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch21_Ch1coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function et_Ch22_Ch1coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch22_Ch1coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch22_Ch1coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch22_Ch1coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch22_Ch1coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch22_Ch1coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function et_Ch23_Ch1coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch23_Ch1coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch23_Ch1coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch23_Ch1coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch23_Ch1coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch23_Ch1coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function et_Ch24_Ch1coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch24_Ch1coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch24_Ch1coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch24_Ch1coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch24_Ch1coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch24_Ch1coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch17_Ch2coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch17_Ch2coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch17_Ch2coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch17_Ch2coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch17_Ch2coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch17_Ch2coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch18_Ch2coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch18_Ch2coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch18_Ch2coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch18_Ch2coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch18_Ch2coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch18_Ch2coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch19_Ch2coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch19_Ch2coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch19_Ch2coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch19_Ch2coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch19_Ch2coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch19_Ch2coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch20_Ch2coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch20_Ch2coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch20_Ch2coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch20_Ch2coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch20_Ch2coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch20_Ch2coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch21_Ch2coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch21_Ch2coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch21_Ch2coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch21_Ch2coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch21_Ch2coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch21_Ch2coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch22_Ch2coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch22_Ch2coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch22_Ch2coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch22_Ch2coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch22_Ch2coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch22_Ch2coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch23_Ch2coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch23_Ch2coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch23_Ch2coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch23_Ch2coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch23_Ch2coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch23_Ch2coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch24_Ch2coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch24_Ch2coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch24_Ch2coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch24_Ch2coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch24_Ch2coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch24_Ch2coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch17_Ch3coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch17_Ch3coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch17_Ch3coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch17_Ch3coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch17_Ch3coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch17_Ch3coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch18_Ch3coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch18_Ch3coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch18_Ch3coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch18_Ch3coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch18_Ch3coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch18_Ch3coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch19_Ch3coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch19_Ch3coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch19_Ch3coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch19_Ch3coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch19_Ch3coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch19_Ch3coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch20_Ch3coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch20_Ch3coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch20_Ch3coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch20_Ch3coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch20_Ch3coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch20_Ch3coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch21_Ch3coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch21_Ch3coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch21_Ch3coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch21_Ch3coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch21_Ch3coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch21_Ch3coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch22_Ch3coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch22_Ch3coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch22_Ch3coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch22_Ch3coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch22_Ch3coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch22_Ch3coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch23_Ch3coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch23_Ch3coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch23_Ch3coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch23_Ch3coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch23_Ch3coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch23_Ch3coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch24_Ch3coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch24_Ch3coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch24_Ch3coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch24_Ch3coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch24_Ch3coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch24_Ch3coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch17_Ch4coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch17_Ch4coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch17_Ch4coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch17_Ch4coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch17_Ch4coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch17_Ch4coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch18_Ch4coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch18_Ch4coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch18_Ch4coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch18_Ch4coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch18_Ch4coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch18_Ch4coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch19_Ch4coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch19_Ch4coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch19_Ch4coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch19_Ch4coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch19_Ch4coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch19_Ch4coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch20_Ch4coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch20_Ch4coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch20_Ch4coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch20_Ch4coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch20_Ch4coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch20_Ch4coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch21_Ch4coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch21_Ch4coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch21_Ch4coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch21_Ch4coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch21_Ch4coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch21_Ch4coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch22_Ch4coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch22_Ch4coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch22_Ch4coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch22_Ch4coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch22_Ch4coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch22_Ch4coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch23_Ch4coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch23_Ch4coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch23_Ch4coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch23_Ch4coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch23_Ch4coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch23_Ch4coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch24_Ch4coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch24_Ch4coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch24_Ch4coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch24_Ch4coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch24_Ch4coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch24_Ch4coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch17_Ch5coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch17_Ch5coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch17_Ch5coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch17_Ch5coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch17_Ch5coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch17_Ch5coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch18_Ch5coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch18_Ch5coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch18_Ch5coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch18_Ch5coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch18_Ch5coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch18_Ch5coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch19_Ch5coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch19_Ch5coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch19_Ch5coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch19_Ch5coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch19_Ch5coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch19_Ch5coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch20_Ch5coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch20_Ch5coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch20_Ch5coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch20_Ch5coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch20_Ch5coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch20_Ch5coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch21_Ch5coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch21_Ch5coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch21_Ch5coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch21_Ch5coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch21_Ch5coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch21_Ch5coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch22_Ch5coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch22_Ch5coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch22_Ch5coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch22_Ch5coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch22_Ch5coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch22_Ch5coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch23_Ch5coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch23_Ch5coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch23_Ch5coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch23_Ch5coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch23_Ch5coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch23_Ch5coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch24_Ch5coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch24_Ch5coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch24_Ch5coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch24_Ch5coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch24_Ch5coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch24_Ch5coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch17_Ch6coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch17_Ch6coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch17_Ch6coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch17_Ch6coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch17_Ch6coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch17_Ch6coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch18_Ch6coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch18_Ch6coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch18_Ch6coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch18_Ch6coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch18_Ch6coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch18_Ch6coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch19_Ch6coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch19_Ch6coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch19_Ch6coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch19_Ch6coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch19_Ch6coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch19_Ch6coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch20_Ch6coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch20_Ch6coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch20_Ch6coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch20_Ch6coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch20_Ch6coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch20_Ch6coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch21_Ch6coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch21_Ch6coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch21_Ch6coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch21_Ch6coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch21_Ch6coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch21_Ch6coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch22_Ch6coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch22_Ch6coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch22_Ch6coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch22_Ch6coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch22_Ch6coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch22_Ch6coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch23_Ch6coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch23_Ch6coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch23_Ch6coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch23_Ch6coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch23_Ch6coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch23_Ch6coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch24_Ch6coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch24_Ch6coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch24_Ch6coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch24_Ch6coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch24_Ch6coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch24_Ch6coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch17_Ch7coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch17_Ch7coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch17_Ch7coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch17_Ch7coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch17_Ch7coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch17_Ch7coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch18_Ch7coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch18_Ch7coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch18_Ch7coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch18_Ch7coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch18_Ch7coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch18_Ch7coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch19_Ch7coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch19_Ch7coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch19_Ch7coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch19_Ch7coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch19_Ch7coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch19_Ch7coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch20_Ch7coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch20_Ch7coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch20_Ch7coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch20_Ch7coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch20_Ch7coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch20_Ch7coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch21_Ch7coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch21_Ch7coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch21_Ch7coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch21_Ch7coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch21_Ch7coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch21_Ch7coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch22_Ch7coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch22_Ch7coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch22_Ch7coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch22_Ch7coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch22_Ch7coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch22_Ch7coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch23_Ch7coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch23_Ch7coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch23_Ch7coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch23_Ch7coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch23_Ch7coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch23_Ch7coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch24_Ch7coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch24_Ch7coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch24_Ch7coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch24_Ch7coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch24_Ch7coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch24_Ch7coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch17_Ch8coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch17_Ch8coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch17_Ch8coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch17_Ch8coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch17_Ch8coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch17_Ch8coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch18_Ch8coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch18_Ch8coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch18_Ch8coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch18_Ch8coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch18_Ch8coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch18_Ch8coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch19_Ch8coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch19_Ch8coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch19_Ch8coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch19_Ch8coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch19_Ch8coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch19_Ch8coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch20_Ch8coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch20_Ch8coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch20_Ch8coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch20_Ch8coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch20_Ch8coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch20_Ch8coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch21_Ch8coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch21_Ch8coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch21_Ch8coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch21_Ch8coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch21_Ch8coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch21_Ch8coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch22_Ch8coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch22_Ch8coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch22_Ch8coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch22_Ch8coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch22_Ch8coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch22_Ch8coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch23_Ch8coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch23_Ch8coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch23_Ch8coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch23_Ch8coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch23_Ch8coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch23_Ch8coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch24_Ch8coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch24_Ch8coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch24_Ch8coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch24_Ch8coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch24_Ch8coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch24_Ch8coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch17_Ch9coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch17_Ch9coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch17_Ch9coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch17_Ch9coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch17_Ch9coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch17_Ch9coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch18_Ch9coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch18_Ch9coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch18_Ch9coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch18_Ch9coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch18_Ch9coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch18_Ch9coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch19_Ch9coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch19_Ch9coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch19_Ch9coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch19_Ch9coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch19_Ch9coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch19_Ch9coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch20_Ch9coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch20_Ch9coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch20_Ch9coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch20_Ch9coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch20_Ch9coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch20_Ch9coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch21_Ch9coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch21_Ch9coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch21_Ch9coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch21_Ch9coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch21_Ch9coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch21_Ch9coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch22_Ch9coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch22_Ch9coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch22_Ch9coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch22_Ch9coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch22_Ch9coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch22_Ch9coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch23_Ch9coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch23_Ch9coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch23_Ch9coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch23_Ch9coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch23_Ch9coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch23_Ch9coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch24_Ch9coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch24_Ch9coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch24_Ch9coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch24_Ch9coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch24_Ch9coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch24_Ch9coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch17_Ch10coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch17_Ch10coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch17_Ch10coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch17_Ch10coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch17_Ch10coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch17_Ch10coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch18_Ch10coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch18_Ch10coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch18_Ch10coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch18_Ch10coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch18_Ch10coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch18_Ch10coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch19_Ch10coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch19_Ch10coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch19_Ch10coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch19_Ch10coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch19_Ch10coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch19_Ch10coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch20_Ch10coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch20_Ch10coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch20_Ch10coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch20_Ch10coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch20_Ch10coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch20_Ch10coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch21_Ch10coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch21_Ch10coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch21_Ch10coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch21_Ch10coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch21_Ch10coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch21_Ch10coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch22_Ch10coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch22_Ch10coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch22_Ch10coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch22_Ch10coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch22_Ch10coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch22_Ch10coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch23_Ch10coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch23_Ch10coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch23_Ch10coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch23_Ch10coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch23_Ch10coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch23_Ch10coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch24_Ch10coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch24_Ch10coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch24_Ch10coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch24_Ch10coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch24_Ch10coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch24_Ch10coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch17_Ch11coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch17_Ch11coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch17_Ch11coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch17_Ch11coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch17_Ch11coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch17_Ch11coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch18_Ch11coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch18_Ch11coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch18_Ch11coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch18_Ch11coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch18_Ch11coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch18_Ch11coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch19_Ch11coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch19_Ch11coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch19_Ch11coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch19_Ch11coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch19_Ch11coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch19_Ch11coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch20_Ch11coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch20_Ch11coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch20_Ch11coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch20_Ch11coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch20_Ch11coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch20_Ch11coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch21_Ch11coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch21_Ch11coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch21_Ch11coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch21_Ch11coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch21_Ch11coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch21_Ch11coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch22_Ch11coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch22_Ch11coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch22_Ch11coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch22_Ch11coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch22_Ch11coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch22_Ch11coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch23_Ch11coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch23_Ch11coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch23_Ch11coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch23_Ch11coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch23_Ch11coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch23_Ch11coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch24_Ch11coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch24_Ch11coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch24_Ch11coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch24_Ch11coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch24_Ch11coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch24_Ch11coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch17_Ch12coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch17_Ch12coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch17_Ch12coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch17_Ch12coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch17_Ch12coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch17_Ch12coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch18_Ch12coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch18_Ch12coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch18_Ch12coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch18_Ch12coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch18_Ch12coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch18_Ch12coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch19_Ch12coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch19_Ch12coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch19_Ch12coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch19_Ch12coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch19_Ch12coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch19_Ch12coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch20_Ch12coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch20_Ch12coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch20_Ch12coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch20_Ch12coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch20_Ch12coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch20_Ch12coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch21_Ch12coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch21_Ch12coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch21_Ch12coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch21_Ch12coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch21_Ch12coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch21_Ch12coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch22_Ch12coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch22_Ch12coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch22_Ch12coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch22_Ch12coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch22_Ch12coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch22_Ch12coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch23_Ch12coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch23_Ch12coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch23_Ch12coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch23_Ch12coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch23_Ch12coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch23_Ch12coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch24_Ch12coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch24_Ch12coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch24_Ch12coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch24_Ch12coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch24_Ch12coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch24_Ch12coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch17_Ch13coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch17_Ch13coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch17_Ch13coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch17_Ch13coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch17_Ch13coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch17_Ch13coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch18_Ch13coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch18_Ch13coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch18_Ch13coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch18_Ch13coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch18_Ch13coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch18_Ch13coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch19_Ch13coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch19_Ch13coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch19_Ch13coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch19_Ch13coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch19_Ch13coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch19_Ch13coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch20_Ch13coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch20_Ch13coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch20_Ch13coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch20_Ch13coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch20_Ch13coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch20_Ch13coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch21_Ch13coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch21_Ch13coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch21_Ch13coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch21_Ch13coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch21_Ch13coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch21_Ch13coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch22_Ch13coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch22_Ch13coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch22_Ch13coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch22_Ch13coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch22_Ch13coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch22_Ch13coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch23_Ch13coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch23_Ch13coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch23_Ch13coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch23_Ch13coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch23_Ch13coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch23_Ch13coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch24_Ch13coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch24_Ch13coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch24_Ch13coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch24_Ch13coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch24_Ch13coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch24_Ch13coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch17_Ch14coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch17_Ch14coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch17_Ch14coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch17_Ch14coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch17_Ch14coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch17_Ch14coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch18_Ch14coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch18_Ch14coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch18_Ch14coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch18_Ch14coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch18_Ch14coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch18_Ch14coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch19_Ch14coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch19_Ch14coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch19_Ch14coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch19_Ch14coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch19_Ch14coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch19_Ch14coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch20_Ch14coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch20_Ch14coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch20_Ch14coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch20_Ch14coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch20_Ch14coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch20_Ch14coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch21_Ch14coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch21_Ch14coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch21_Ch14coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch21_Ch14coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch21_Ch14coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch21_Ch14coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch22_Ch14coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch22_Ch14coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch22_Ch14coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch22_Ch14coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch22_Ch14coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch22_Ch14coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch23_Ch14coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch23_Ch14coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch23_Ch14coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch23_Ch14coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch23_Ch14coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch23_Ch14coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch24_Ch14coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch24_Ch14coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch24_Ch14coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch24_Ch14coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch24_Ch14coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch24_Ch14coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch17_Ch15coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch17_Ch15coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch17_Ch15coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch17_Ch15coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch17_Ch15coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch17_Ch15coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch18_Ch15coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch18_Ch15coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch18_Ch15coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch18_Ch15coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch18_Ch15coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch18_Ch15coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch19_Ch15coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch19_Ch15coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch19_Ch15coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch19_Ch15coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch19_Ch15coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch19_Ch15coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch20_Ch15coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch20_Ch15coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch20_Ch15coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch20_Ch15coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch20_Ch15coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch20_Ch15coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch21_Ch15coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch21_Ch15coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch21_Ch15coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch21_Ch15coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch21_Ch15coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch21_Ch15coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch22_Ch15coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch22_Ch15coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch22_Ch15coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch22_Ch15coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch22_Ch15coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch22_Ch15coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch23_Ch15coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch23_Ch15coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch23_Ch15coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch23_Ch15coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch23_Ch15coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch23_Ch15coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch24_Ch15coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch24_Ch15coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch24_Ch15coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch24_Ch15coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch24_Ch15coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch24_Ch15coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch17_Ch16coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch17_Ch16coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch17_Ch16coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch17_Ch16coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch17_Ch16coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch17_Ch16coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch18_Ch16coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch18_Ch16coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch18_Ch16coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch18_Ch16coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch18_Ch16coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch18_Ch16coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch19_Ch16coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch19_Ch16coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch19_Ch16coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch19_Ch16coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch19_Ch16coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch19_Ch16coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch20_Ch16coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch20_Ch16coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch20_Ch16coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch20_Ch16coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch20_Ch16coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch20_Ch16coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch21_Ch16coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch21_Ch16coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch21_Ch16coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch21_Ch16coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch21_Ch16coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch21_Ch16coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch22_Ch16coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch22_Ch16coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch22_Ch16coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch22_Ch16coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch22_Ch16coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch22_Ch16coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch23_Ch16coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch23_Ch16coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch23_Ch16coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch23_Ch16coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch23_Ch16coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch23_Ch16coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_Ch24_Ch16coeff_Callback(hObject, eventdata, handles)
% hObject    handle to et_Ch24_Ch16coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_Ch24_Ch16coeff as text
%        str2double(get(hObject,'String')) returns contents of et_Ch24_Ch16coeff as a double


% --- Executes during object creation, after setting all properties.
function et_Ch24_Ch16coeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_Ch24_Ch16coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function menu_connect_Callback(hObject, eventdata, handles)
% hObject    handle to menu_connect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Ask for connection settings
    prompt = {'Enter COM Port:','Enter baudrate:'};
    dlg_title = 'Connect';
    num_lines = 1;
    def = {'5','460800'};
    answer = inputdlg(prompt,dlg_title,num_lines,def);
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
        set(handles.t_msg,'String','Connection Established');
    else
        set(handles.t_msg,'String','Error, device is not responding or COM port is changed!');        
    end
    fclose(obj);
    handles.obj = obj;
    guidata(hObject,handles);
  

% --- Executes on button press in pb_write.
function pb_write_Callback(hObject, eventdata, handles)
% hObject    handle to pb_write (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    % Get connection object
    if isfield(handles,'obj')
        obj = handles.obj;
    else
        set(handles.t_msg,'String','No connection obj found'); 
        return;
    end
    
    PCACoefficients = zeros(8,16);
    
    PCACoefficients(1,1) = str2double(get(handles.et_Ch17_Ch1coeff,'String'));
    PCACoefficients(1,2) = str2double(get(handles.et_Ch17_Ch2coeff,'String'));
    PCACoefficients(1,3) = str2double(get(handles.et_Ch17_Ch3coeff,'String'));
    PCACoefficients(1,4) = str2double(get(handles.et_Ch17_Ch4coeff,'String'));
    PCACoefficients(1,5) = str2double(get(handles.et_Ch17_Ch5coeff,'String'));
    PCACoefficients(1,6) = str2double(get(handles.et_Ch17_Ch6coeff,'String'));
    PCACoefficients(1,7) = str2double(get(handles.et_Ch17_Ch7coeff,'String'));
    PCACoefficients(1,8) = str2double(get(handles.et_Ch17_Ch8coeff,'String'));
    PCACoefficients(1,9) = str2double(get(handles.et_Ch17_Ch9coeff,'String'));
    PCACoefficients(1,10) = str2double(get(handles.et_Ch17_Ch10coeff,'String'));
    PCACoefficients(1,11) = str2double(get(handles.et_Ch17_Ch11coeff,'String'));
    PCACoefficients(1,12) = str2double(get(handles.et_Ch17_Ch12coeff,'String'));
    PCACoefficients(1,13) = str2double(get(handles.et_Ch17_Ch13coeff,'String'));
    PCACoefficients(1,14) = str2double(get(handles.et_Ch17_Ch14coeff,'String'));
    PCACoefficients(1,15) = str2double(get(handles.et_Ch17_Ch15coeff,'String'));
    PCACoefficients(1,16) = str2double(get(handles.et_Ch17_Ch16coeff,'String'));

    PCACoefficients(2,1) = str2double(get(handles.et_Ch18_Ch1coeff,'String'));
    PCACoefficients(2,2) = str2double(get(handles.et_Ch18_Ch2coeff,'String'));
    PCACoefficients(2,3) = str2double(get(handles.et_Ch18_Ch3coeff,'String'));
    PCACoefficients(2,4) = str2double(get(handles.et_Ch18_Ch4coeff,'String'));
    PCACoefficients(2,5) = str2double(get(handles.et_Ch18_Ch5coeff,'String'));
    PCACoefficients(2,6) = str2double(get(handles.et_Ch18_Ch6coeff,'String'));
    PCACoefficients(2,7) = str2double(get(handles.et_Ch18_Ch7coeff,'String'));
    PCACoefficients(2,8) = str2double(get(handles.et_Ch18_Ch8coeff,'String'));
    PCACoefficients(2,9) = str2double(get(handles.et_Ch18_Ch9coeff,'String'));
    PCACoefficients(2,10) = str2double(get(handles.et_Ch18_Ch10coeff,'String'));
    PCACoefficients(2,11) = str2double(get(handles.et_Ch18_Ch11coeff,'String'));
    PCACoefficients(2,12) = str2double(get(handles.et_Ch18_Ch12coeff,'String'));
    PCACoefficients(2,13) = str2double(get(handles.et_Ch18_Ch13coeff,'String'));
    PCACoefficients(2,14) = str2double(get(handles.et_Ch18_Ch14coeff,'String'));
    PCACoefficients(2,15) = str2double(get(handles.et_Ch18_Ch15coeff,'String'));
    PCACoefficients(2,16) = str2double(get(handles.et_Ch18_Ch16coeff,'String'));
    
    PCACoefficients(3,1) = str2double(get(handles.et_Ch19_Ch1coeff,'String'));
    PCACoefficients(3,2) = str2double(get(handles.et_Ch19_Ch2coeff,'String'));
    PCACoefficients(3,3) = str2double(get(handles.et_Ch19_Ch3coeff,'String'));
    PCACoefficients(3,4) = str2double(get(handles.et_Ch19_Ch4coeff,'String'));
    PCACoefficients(3,5) = str2double(get(handles.et_Ch19_Ch5coeff,'String'));
    PCACoefficients(3,6) = str2double(get(handles.et_Ch19_Ch6coeff,'String'));
    PCACoefficients(3,7) = str2double(get(handles.et_Ch19_Ch7coeff,'String'));
    PCACoefficients(3,8) = str2double(get(handles.et_Ch19_Ch8coeff,'String'));
    PCACoefficients(3,9) = str2double(get(handles.et_Ch19_Ch9coeff,'String'));
    PCACoefficients(3,10) = str2double(get(handles.et_Ch19_Ch10coeff,'String'));
    PCACoefficients(3,11) = str2double(get(handles.et_Ch19_Ch11coeff,'String'));
    PCACoefficients(3,12) = str2double(get(handles.et_Ch19_Ch12coeff,'String'));
    PCACoefficients(3,13) = str2double(get(handles.et_Ch19_Ch13coeff,'String'));
    PCACoefficients(3,14) = str2double(get(handles.et_Ch19_Ch14coeff,'String'));
    PCACoefficients(3,15) = str2double(get(handles.et_Ch19_Ch15coeff,'String'));
    PCACoefficients(3,16) = str2double(get(handles.et_Ch19_Ch16coeff,'String'));
    
    PCACoefficients(4,1) = str2double(get(handles.et_Ch20_Ch1coeff,'String'));
    PCACoefficients(4,2) = str2double(get(handles.et_Ch20_Ch2coeff,'String'));
    PCACoefficients(4,3) = str2double(get(handles.et_Ch20_Ch3coeff,'String'));
    PCACoefficients(4,4) = str2double(get(handles.et_Ch20_Ch4coeff,'String'));
    PCACoefficients(4,5) = str2double(get(handles.et_Ch20_Ch5coeff,'String'));
    PCACoefficients(4,6) = str2double(get(handles.et_Ch20_Ch6coeff,'String'));
    PCACoefficients(4,7) = str2double(get(handles.et_Ch20_Ch7coeff,'String'));
    PCACoefficients(4,8) = str2double(get(handles.et_Ch20_Ch8coeff,'String'));
    PCACoefficients(4,9) = str2double(get(handles.et_Ch20_Ch9coeff,'String'));
    PCACoefficients(4,10) = str2double(get(handles.et_Ch20_Ch10coeff,'String'));
    PCACoefficients(4,11) = str2double(get(handles.et_Ch20_Ch11coeff,'String'));
    PCACoefficients(4,12) = str2double(get(handles.et_Ch20_Ch12coeff,'String'));
    PCACoefficients(4,13) = str2double(get(handles.et_Ch20_Ch13coeff,'String'));
    PCACoefficients(4,14) = str2double(get(handles.et_Ch20_Ch14coeff,'String'));
    PCACoefficients(4,15) = str2double(get(handles.et_Ch20_Ch15coeff,'String'));
    PCACoefficients(4,16) = str2double(get(handles.et_Ch20_Ch16coeff,'String'));
    
    PCACoefficients(5,1) = str2double(get(handles.et_Ch21_Ch1coeff,'String'));
    PCACoefficients(5,2) = str2double(get(handles.et_Ch21_Ch2coeff,'String'));
    PCACoefficients(5,3) = str2double(get(handles.et_Ch21_Ch3coeff,'String'));
    PCACoefficients(5,4) = str2double(get(handles.et_Ch21_Ch4coeff,'String'));
    PCACoefficients(5,5) = str2double(get(handles.et_Ch21_Ch5coeff,'String'));
    PCACoefficients(5,6) = str2double(get(handles.et_Ch21_Ch6coeff,'String'));
    PCACoefficients(5,7) = str2double(get(handles.et_Ch21_Ch7coeff,'String'));
    PCACoefficients(5,8) = str2double(get(handles.et_Ch21_Ch8coeff,'String'));
    PCACoefficients(5,9) = str2double(get(handles.et_Ch21_Ch9coeff,'String'));
    PCACoefficients(5,10) = str2double(get(handles.et_Ch21_Ch10coeff,'String'));
    PCACoefficients(5,11) = str2double(get(handles.et_Ch21_Ch11coeff,'String'));
    PCACoefficients(5,12) = str2double(get(handles.et_Ch21_Ch12coeff,'String'));
    PCACoefficients(5,13) = str2double(get(handles.et_Ch21_Ch13coeff,'String'));
    PCACoefficients(5,14) = str2double(get(handles.et_Ch21_Ch14coeff,'String'));
    PCACoefficients(5,15) = str2double(get(handles.et_Ch21_Ch15coeff,'String'));
    PCACoefficients(5,16) = str2double(get(handles.et_Ch21_Ch16coeff,'String'));
    
    PCACoefficients(6,1) = str2double(get(handles.et_Ch22_Ch1coeff,'String'));
    PCACoefficients(6,2) = str2double(get(handles.et_Ch22_Ch2coeff,'String'));
    PCACoefficients(6,3) = str2double(get(handles.et_Ch22_Ch3coeff,'String'));
    PCACoefficients(6,4) = str2double(get(handles.et_Ch22_Ch4coeff,'String'));
    PCACoefficients(6,5) = str2double(get(handles.et_Ch22_Ch5coeff,'String'));
    PCACoefficients(6,6) = str2double(get(handles.et_Ch22_Ch6coeff,'String'));
    PCACoefficients(6,7) = str2double(get(handles.et_Ch22_Ch7coeff,'String'));
    PCACoefficients(6,8) = str2double(get(handles.et_Ch22_Ch8coeff,'String'));
    PCACoefficients(6,9) = str2double(get(handles.et_Ch22_Ch9coeff,'String'));
    PCACoefficients(6,10) = str2double(get(handles.et_Ch22_Ch10coeff,'String'));
    PCACoefficients(6,11) = str2double(get(handles.et_Ch22_Ch11coeff,'String'));
    PCACoefficients(6,12) = str2double(get(handles.et_Ch22_Ch12coeff,'String'));
    PCACoefficients(6,13) = str2double(get(handles.et_Ch22_Ch13coeff,'String'));
    PCACoefficients(6,14) = str2double(get(handles.et_Ch22_Ch14coeff,'String'));
    PCACoefficients(6,15) = str2double(get(handles.et_Ch22_Ch15coeff,'String'));
    PCACoefficients(6,16) = str2double(get(handles.et_Ch22_Ch16coeff,'String'));
    
    PCACoefficients(7,1) = str2double(get(handles.et_Ch23_Ch1coeff,'String'));
    PCACoefficients(7,2) = str2double(get(handles.et_Ch23_Ch2coeff,'String'));
    PCACoefficients(7,3) = str2double(get(handles.et_Ch23_Ch3coeff,'String'));
    PCACoefficients(7,4) = str2double(get(handles.et_Ch23_Ch4coeff,'String'));
    PCACoefficients(7,5) = str2double(get(handles.et_Ch23_Ch5coeff,'String'));
    PCACoefficients(7,6) = str2double(get(handles.et_Ch23_Ch6coeff,'String'));
    PCACoefficients(7,7) = str2double(get(handles.et_Ch23_Ch7coeff,'String'));
    PCACoefficients(7,8) = str2double(get(handles.et_Ch23_Ch8coeff,'String'));
    PCACoefficients(7,9) = str2double(get(handles.et_Ch23_Ch9coeff,'String'));
    PCACoefficients(7,10) = str2double(get(handles.et_Ch23_Ch10coeff,'String'));
    PCACoefficients(7,11) = str2double(get(handles.et_Ch23_Ch11coeff,'String'));
    PCACoefficients(7,12) = str2double(get(handles.et_Ch23_Ch12coeff,'String'));
    PCACoefficients(7,13) = str2double(get(handles.et_Ch23_Ch13coeff,'String'));
    PCACoefficients(7,14) = str2double(get(handles.et_Ch23_Ch14coeff,'String'));
    PCACoefficients(7,15) = str2double(get(handles.et_Ch23_Ch15coeff,'String'));
    PCACoefficients(7,16) = str2double(get(handles.et_Ch23_Ch16coeff,'String'));
    
    PCACoefficients(8,1) = str2double(get(handles.et_Ch24_Ch1coeff,'String'));
    PCACoefficients(8,2) = str2double(get(handles.et_Ch24_Ch2coeff,'String'));
    PCACoefficients(8,3) = str2double(get(handles.et_Ch24_Ch3coeff,'String'));
    PCACoefficients(8,4) = str2double(get(handles.et_Ch24_Ch4coeff,'String'));
    PCACoefficients(8,5) = str2double(get(handles.et_Ch24_Ch5coeff,'String'));
    PCACoefficients(8,6) = str2double(get(handles.et_Ch24_Ch6coeff,'String'));
    PCACoefficients(8,7) = str2double(get(handles.et_Ch24_Ch7coeff,'String'));
    PCACoefficients(8,8) = str2double(get(handles.et_Ch24_Ch8coeff,'String'));
    PCACoefficients(8,9) = str2double(get(handles.et_Ch24_Ch9coeff,'String'));
    PCACoefficients(8,10) = str2double(get(handles.et_Ch24_Ch10coeff,'String'));
    PCACoefficients(8,11) = str2double(get(handles.et_Ch24_Ch11coeff,'String'));
    PCACoefficients(8,12) = str2double(get(handles.et_Ch24_Ch12coeff,'String'));
    PCACoefficients(8,13) = str2double(get(handles.et_Ch24_Ch13coeff,'String'));
    PCACoefficients(8,14) = str2double(get(handles.et_Ch24_Ch14coeff,'String'));
    PCACoefficients(8,15) = str2double(get(handles.et_Ch24_Ch15coeff,'String'));
    PCACoefficients(8,16) = str2double(get(handles.et_Ch24_Ch16coeff,'String'));
    
    if isfield(handles,'obj')
        obj = handles.obj;
    else
        set(handles.t_msg,'String','No connection obj found'); 
        return;
    end
    
    % Open the connection
    fopen(obj);
    % Write 
    fwrite(obj,'O','char');
    replay = char(fread(obj,1,'char'));
    if strcmp(replay,'O')
        for i = 1:8
            for k = 1:16
                fwrite(obj,PCACoefficients(i,k),'float32');
            end
        end
        replay = char(fread(obj,1,'char'));
        if strcmp(replay,'O')
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
    
    

% --- Executes on button press in pb_read.
function pb_read_Callback(hObject, eventdata, handles)
% hObject    handle to pb_read (see GCBO)
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
    % read settings
    fwrite(obj,'F','char');
    replay = char(fread(obj,1,'char'));
    if strcmp(replay,'F')
        for i = 1:8
            for k = 1:16
                PCACoefficients(i,k) = fread(obj,1,'float32');
            end
        end

        set(handles.et_Ch17_Ch1coeff,'String',num2str(PCACoefficients(1,1)));
        set(handles.et_Ch17_Ch2coeff,'String',num2str(PCACoefficients(1,2)));
        set(handles.et_Ch17_Ch3coeff,'String',num2str(PCACoefficients(1,3)));
        set(handles.et_Ch17_Ch4coeff,'String',num2str(PCACoefficients(1,4)));
        set(handles.et_Ch17_Ch5coeff,'String',num2str(PCACoefficients(1,5)));
        set(handles.et_Ch17_Ch6coeff,'String',num2str(PCACoefficients(1,6)));
        set(handles.et_Ch17_Ch7coeff,'String',num2str(PCACoefficients(1,7)));
        set(handles.et_Ch17_Ch8coeff,'String',num2str(PCACoefficients(1,8)));
        set(handles.et_Ch17_Ch9coeff,'String',num2str(PCACoefficients(1,9)));
        set(handles.et_Ch17_Ch10coeff,'String',num2str(PCACoefficients(1,10)));
        set(handles.et_Ch17_Ch11coeff,'String',num2str(PCACoefficients(1,11)));
        set(handles.et_Ch17_Ch12coeff,'String',num2str(PCACoefficients(1,12)));
        set(handles.et_Ch17_Ch13coeff,'String',num2str(PCACoefficients(1,13)));
        set(handles.et_Ch17_Ch14coeff,'String',num2str(PCACoefficients(1,14)));
        set(handles.et_Ch17_Ch15coeff,'String',num2str(PCACoefficients(1,15)));
        set(handles.et_Ch17_Ch16coeff,'String',num2str(PCACoefficients(1,16)));
        
        set(handles.et_Ch18_Ch1coeff,'String',num2str(PCACoefficients(2,1)));
        set(handles.et_Ch18_Ch2coeff,'String',num2str(PCACoefficients(2,2)));
        set(handles.et_Ch18_Ch3coeff,'String',num2str(PCACoefficients(2,3)));
        set(handles.et_Ch18_Ch4coeff,'String',num2str(PCACoefficients(2,4)));
        set(handles.et_Ch18_Ch5coeff,'String',num2str(PCACoefficients(2,5)));
        set(handles.et_Ch18_Ch6coeff,'String',num2str(PCACoefficients(2,6)));
        set(handles.et_Ch18_Ch7coeff,'String',num2str(PCACoefficients(2,7)));
        set(handles.et_Ch18_Ch8coeff,'String',num2str(PCACoefficients(2,8)));
        set(handles.et_Ch18_Ch9coeff,'String',num2str(PCACoefficients(2,9)));
        set(handles.et_Ch18_Ch10coeff,'String',num2str(PCACoefficients(2,10)));
        set(handles.et_Ch18_Ch11coeff,'String',num2str(PCACoefficients(2,11)));
        set(handles.et_Ch18_Ch12coeff,'String',num2str(PCACoefficients(2,12)));
        set(handles.et_Ch18_Ch13coeff,'String',num2str(PCACoefficients(2,13)));
        set(handles.et_Ch18_Ch14coeff,'String',num2str(PCACoefficients(2,14)));
        set(handles.et_Ch18_Ch15coeff,'String',num2str(PCACoefficients(2,15)));
        set(handles.et_Ch18_Ch16coeff,'String',num2str(PCACoefficients(2,16)));
        
        set(handles.et_Ch19_Ch1coeff,'String',num2str(PCACoefficients(3,1)));
        set(handles.et_Ch19_Ch2coeff,'String',num2str(PCACoefficients(3,2)));
        set(handles.et_Ch19_Ch3coeff,'String',num2str(PCACoefficients(3,3)));
        set(handles.et_Ch19_Ch4coeff,'String',num2str(PCACoefficients(3,4)));
        set(handles.et_Ch19_Ch5coeff,'String',num2str(PCACoefficients(3,5)));
        set(handles.et_Ch19_Ch6coeff,'String',num2str(PCACoefficients(3,6)));
        set(handles.et_Ch19_Ch7coeff,'String',num2str(PCACoefficients(3,7)));
        set(handles.et_Ch19_Ch8coeff,'String',num2str(PCACoefficients(3,8)));
        set(handles.et_Ch19_Ch9coeff,'String',num2str(PCACoefficients(3,9)));
        set(handles.et_Ch19_Ch10coeff,'String',num2str(PCACoefficients(3,10)));
        set(handles.et_Ch19_Ch11coeff,'String',num2str(PCACoefficients(3,11)));
        set(handles.et_Ch19_Ch12coeff,'String',num2str(PCACoefficients(3,12)));
        set(handles.et_Ch19_Ch13coeff,'String',num2str(PCACoefficients(3,13)));
        set(handles.et_Ch19_Ch14coeff,'String',num2str(PCACoefficients(3,14)));
        set(handles.et_Ch19_Ch15coeff,'String',num2str(PCACoefficients(3,15)));
        set(handles.et_Ch19_Ch16coeff,'String',num2str(PCACoefficients(3,16)));
        
        set(handles.et_Ch20_Ch1coeff,'String',num2str(PCACoefficients(4,1)));
        set(handles.et_Ch20_Ch2coeff,'String',num2str(PCACoefficients(4,2)));
        set(handles.et_Ch20_Ch3coeff,'String',num2str(PCACoefficients(4,3)));
        set(handles.et_Ch20_Ch4coeff,'String',num2str(PCACoefficients(4,4)));
        set(handles.et_Ch20_Ch5coeff,'String',num2str(PCACoefficients(4,5)));
        set(handles.et_Ch20_Ch6coeff,'String',num2str(PCACoefficients(4,6)));
        set(handles.et_Ch20_Ch7coeff,'String',num2str(PCACoefficients(4,7)));
        set(handles.et_Ch20_Ch8coeff,'String',num2str(PCACoefficients(4,8)));
        set(handles.et_Ch20_Ch9coeff,'String',num2str(PCACoefficients(4,9)));
        set(handles.et_Ch20_Ch10coeff,'String',num2str(PCACoefficients(4,10)));
        set(handles.et_Ch20_Ch11coeff,'String',num2str(PCACoefficients(4,11)));
        set(handles.et_Ch20_Ch12coeff,'String',num2str(PCACoefficients(4,12)));
        set(handles.et_Ch20_Ch13coeff,'String',num2str(PCACoefficients(4,13)));
        set(handles.et_Ch20_Ch14coeff,'String',num2str(PCACoefficients(4,14)));
        set(handles.et_Ch20_Ch15coeff,'String',num2str(PCACoefficients(4,15)));
        set(handles.et_Ch20_Ch16coeff,'String',num2str(PCACoefficients(4,16)));
        
        set(handles.et_Ch21_Ch1coeff,'String',num2str(PCACoefficients(5,1)));
        set(handles.et_Ch21_Ch2coeff,'String',num2str(PCACoefficients(5,2)));
        set(handles.et_Ch21_Ch3coeff,'String',num2str(PCACoefficients(5,3)));
        set(handles.et_Ch21_Ch4coeff,'String',num2str(PCACoefficients(5,4)));
        set(handles.et_Ch21_Ch5coeff,'String',num2str(PCACoefficients(5,5)));
        set(handles.et_Ch21_Ch6coeff,'String',num2str(PCACoefficients(5,6)));
        set(handles.et_Ch21_Ch7coeff,'String',num2str(PCACoefficients(5,7)));
        set(handles.et_Ch21_Ch8coeff,'String',num2str(PCACoefficients(5,8)));
        set(handles.et_Ch21_Ch9coeff,'String',num2str(PCACoefficients(5,9)));
        set(handles.et_Ch21_Ch10coeff,'String',num2str(PCACoefficients(5,10)));
        set(handles.et_Ch21_Ch11coeff,'String',num2str(PCACoefficients(5,11)));
        set(handles.et_Ch21_Ch12coeff,'String',num2str(PCACoefficients(5,12)));
        set(handles.et_Ch21_Ch13coeff,'String',num2str(PCACoefficients(5,13)));
        set(handles.et_Ch21_Ch14coeff,'String',num2str(PCACoefficients(5,14)));
        set(handles.et_Ch21_Ch15coeff,'String',num2str(PCACoefficients(5,15)));
        set(handles.et_Ch21_Ch16coeff,'String',num2str(PCACoefficients(5,16)));
        
        set(handles.et_Ch22_Ch1coeff,'String',num2str(PCACoefficients(6,1)));
        set(handles.et_Ch22_Ch2coeff,'String',num2str(PCACoefficients(6,2)));
        set(handles.et_Ch22_Ch3coeff,'String',num2str(PCACoefficients(6,3)));
        set(handles.et_Ch22_Ch4coeff,'String',num2str(PCACoefficients(6,4)));
        set(handles.et_Ch22_Ch5coeff,'String',num2str(PCACoefficients(6,5)));
        set(handles.et_Ch22_Ch6coeff,'String',num2str(PCACoefficients(6,6)));
        set(handles.et_Ch22_Ch7coeff,'String',num2str(PCACoefficients(6,7)));
        set(handles.et_Ch22_Ch8coeff,'String',num2str(PCACoefficients(6,8)));
        set(handles.et_Ch22_Ch9coeff,'String',num2str(PCACoefficients(6,9)));
        set(handles.et_Ch22_Ch10coeff,'String',num2str(PCACoefficients(6,10)));
        set(handles.et_Ch22_Ch11coeff,'String',num2str(PCACoefficients(6,11)));
        set(handles.et_Ch22_Ch12coeff,'String',num2str(PCACoefficients(6,12)));
        set(handles.et_Ch22_Ch13coeff,'String',num2str(PCACoefficients(6,13)));
        set(handles.et_Ch22_Ch14coeff,'String',num2str(PCACoefficients(6,14)));
        set(handles.et_Ch22_Ch15coeff,'String',num2str(PCACoefficients(6,15)));
        set(handles.et_Ch22_Ch16coeff,'String',num2str(PCACoefficients(6,16)));
        
        set(handles.et_Ch23_Ch1coeff,'String',num2str(PCACoefficients(7,1)));
        set(handles.et_Ch23_Ch2coeff,'String',num2str(PCACoefficients(7,2)));
        set(handles.et_Ch23_Ch3coeff,'String',num2str(PCACoefficients(7,3)));
        set(handles.et_Ch23_Ch4coeff,'String',num2str(PCACoefficients(7,4)));
        set(handles.et_Ch23_Ch5coeff,'String',num2str(PCACoefficients(7,5)));
        set(handles.et_Ch23_Ch6coeff,'String',num2str(PCACoefficients(7,6)));
        set(handles.et_Ch23_Ch7coeff,'String',num2str(PCACoefficients(7,7)));
        set(handles.et_Ch23_Ch8coeff,'String',num2str(PCACoefficients(7,8)));
        set(handles.et_Ch23_Ch9coeff,'String',num2str(PCACoefficients(7,9)));
        set(handles.et_Ch23_Ch10coeff,'String',num2str(PCACoefficients(7,10)));
        set(handles.et_Ch23_Ch11coeff,'String',num2str(PCACoefficients(7,11)));
        set(handles.et_Ch23_Ch12coeff,'String',num2str(PCACoefficients(7,12)));
        set(handles.et_Ch23_Ch13coeff,'String',num2str(PCACoefficients(7,13)));
        set(handles.et_Ch23_Ch14coeff,'String',num2str(PCACoefficients(7,14)));
        set(handles.et_Ch23_Ch15coeff,'String',num2str(PCACoefficients(7,15)));
        set(handles.et_Ch23_Ch16coeff,'String',num2str(PCACoefficients(7,16)));
        
        set(handles.et_Ch24_Ch1coeff,'String',num2str(PCACoefficients(8,1)));
        set(handles.et_Ch24_Ch2coeff,'String',num2str(PCACoefficients(8,2)));
        set(handles.et_Ch24_Ch3coeff,'String',num2str(PCACoefficients(8,3)));
        set(handles.et_Ch24_Ch4coeff,'String',num2str(PCACoefficients(8,4)));
        set(handles.et_Ch24_Ch5coeff,'String',num2str(PCACoefficients(8,5)));
        set(handles.et_Ch24_Ch6coeff,'String',num2str(PCACoefficients(8,6)));
        set(handles.et_Ch24_Ch7coeff,'String',num2str(PCACoefficients(8,7)));
        set(handles.et_Ch24_Ch8coeff,'String',num2str(PCACoefficients(8,8)));
        set(handles.et_Ch24_Ch9coeff,'String',num2str(PCACoefficients(8,9)));
        set(handles.et_Ch24_Ch10coeff,'String',num2str(PCACoefficients(8,10)));
        set(handles.et_Ch24_Ch11coeff,'String',num2str(PCACoefficients(8,11)));
        set(handles.et_Ch24_Ch12coeff,'String',num2str(PCACoefficients(8,12)));
        set(handles.et_Ch24_Ch13coeff,'String',num2str(PCACoefficients(8,13)));
        set(handles.et_Ch24_Ch14coeff,'String',num2str(PCACoefficients(8,14)));
        set(handles.et_Ch24_Ch15coeff,'String',num2str(PCACoefficients(8,15)));
        set(handles.et_Ch24_Ch16coeff,'String',num2str(PCACoefficients(8,16)));
        
        replay = char(fread(obj,1,'char'));
        if strcmp(replay,'F')
            set(handles.t_msg,'String','Control settings correctly requested from ALC-D');
        else
            set(handles.t_msg,'String','Error requesting Control settings'); 
            fclose(obj);
            return
        end
    else
        set(handles.t_msg,'String','Error requesting Control settings'); 
        fclose(obj);
        return
    end

    fclose(obj);
   
    


% --------------------------------------------------------------------
function menu_reset_Callback(hObject, eventdata, handles)
% hObject    handle to menu_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

for i = 1:8
    for k = 1:16
        PCACoefficients(i,k) = 0;
    end
end

set(handles.et_Ch17_Ch1coeff,'String',num2str(PCACoefficients(1,1)));
set(handles.et_Ch17_Ch2coeff,'String',num2str(PCACoefficients(1,2)));
set(handles.et_Ch17_Ch3coeff,'String',num2str(PCACoefficients(1,3)));
set(handles.et_Ch17_Ch4coeff,'String',num2str(PCACoefficients(1,4)));
set(handles.et_Ch17_Ch5coeff,'String',num2str(PCACoefficients(1,5)));
set(handles.et_Ch17_Ch6coeff,'String',num2str(PCACoefficients(1,6)));
set(handles.et_Ch17_Ch7coeff,'String',num2str(PCACoefficients(1,7)));
set(handles.et_Ch17_Ch8coeff,'String',num2str(PCACoefficients(1,8)));
set(handles.et_Ch17_Ch9coeff,'String',num2str(PCACoefficients(1,9)));
set(handles.et_Ch17_Ch10coeff,'String',num2str(PCACoefficients(1,10)));
set(handles.et_Ch17_Ch11coeff,'String',num2str(PCACoefficients(1,11)));
set(handles.et_Ch17_Ch12coeff,'String',num2str(PCACoefficients(1,12)));
set(handles.et_Ch17_Ch13coeff,'String',num2str(PCACoefficients(1,13)));
set(handles.et_Ch17_Ch14coeff,'String',num2str(PCACoefficients(1,14)));
set(handles.et_Ch17_Ch15coeff,'String',num2str(PCACoefficients(1,15)));
set(handles.et_Ch17_Ch16coeff,'String',num2str(PCACoefficients(1,16)));

set(handles.et_Ch18_Ch1coeff,'String',num2str(PCACoefficients(2,1)));
set(handles.et_Ch18_Ch2coeff,'String',num2str(PCACoefficients(2,2)));
set(handles.et_Ch18_Ch3coeff,'String',num2str(PCACoefficients(2,3)));
set(handles.et_Ch18_Ch4coeff,'String',num2str(PCACoefficients(2,4)));
set(handles.et_Ch18_Ch5coeff,'String',num2str(PCACoefficients(2,5)));
set(handles.et_Ch18_Ch6coeff,'String',num2str(PCACoefficients(2,6)));
set(handles.et_Ch18_Ch7coeff,'String',num2str(PCACoefficients(2,7)));
set(handles.et_Ch18_Ch8coeff,'String',num2str(PCACoefficients(2,8)));
set(handles.et_Ch18_Ch9coeff,'String',num2str(PCACoefficients(2,9)));
set(handles.et_Ch18_Ch10coeff,'String',num2str(PCACoefficients(2,10)));
set(handles.et_Ch18_Ch11coeff,'String',num2str(PCACoefficients(2,11)));
set(handles.et_Ch18_Ch12coeff,'String',num2str(PCACoefficients(2,12)));
set(handles.et_Ch18_Ch13coeff,'String',num2str(PCACoefficients(2,13)));
set(handles.et_Ch18_Ch14coeff,'String',num2str(PCACoefficients(2,14)));
set(handles.et_Ch18_Ch15coeff,'String',num2str(PCACoefficients(2,15)));
set(handles.et_Ch18_Ch16coeff,'String',num2str(PCACoefficients(2,16)));

set(handles.et_Ch19_Ch1coeff,'String',num2str(PCACoefficients(3,1)));
set(handles.et_Ch19_Ch2coeff,'String',num2str(PCACoefficients(3,2)));
set(handles.et_Ch19_Ch3coeff,'String',num2str(PCACoefficients(3,3)));
set(handles.et_Ch19_Ch4coeff,'String',num2str(PCACoefficients(3,4)));
set(handles.et_Ch19_Ch5coeff,'String',num2str(PCACoefficients(3,5)));
set(handles.et_Ch19_Ch6coeff,'String',num2str(PCACoefficients(3,6)));
set(handles.et_Ch19_Ch7coeff,'String',num2str(PCACoefficients(3,7)));
set(handles.et_Ch19_Ch8coeff,'String',num2str(PCACoefficients(3,8)));
set(handles.et_Ch19_Ch9coeff,'String',num2str(PCACoefficients(3,9)));
set(handles.et_Ch19_Ch10coeff,'String',num2str(PCACoefficients(3,10)));
set(handles.et_Ch19_Ch11coeff,'String',num2str(PCACoefficients(3,11)));
set(handles.et_Ch19_Ch12coeff,'String',num2str(PCACoefficients(3,12)));
set(handles.et_Ch19_Ch13coeff,'String',num2str(PCACoefficients(3,13)));
set(handles.et_Ch19_Ch14coeff,'String',num2str(PCACoefficients(3,14)));
set(handles.et_Ch19_Ch15coeff,'String',num2str(PCACoefficients(3,15)));
set(handles.et_Ch19_Ch16coeff,'String',num2str(PCACoefficients(3,16)));

set(handles.et_Ch20_Ch1coeff,'String',num2str(PCACoefficients(4,1)));
set(handles.et_Ch20_Ch2coeff,'String',num2str(PCACoefficients(4,2)));
set(handles.et_Ch20_Ch3coeff,'String',num2str(PCACoefficients(4,3)));
set(handles.et_Ch20_Ch4coeff,'String',num2str(PCACoefficients(4,4)));
set(handles.et_Ch20_Ch5coeff,'String',num2str(PCACoefficients(4,5)));
set(handles.et_Ch20_Ch6coeff,'String',num2str(PCACoefficients(4,6)));
set(handles.et_Ch20_Ch7coeff,'String',num2str(PCACoefficients(4,7)));
set(handles.et_Ch20_Ch8coeff,'String',num2str(PCACoefficients(4,8)));
set(handles.et_Ch20_Ch9coeff,'String',num2str(PCACoefficients(4,9)));
set(handles.et_Ch20_Ch10coeff,'String',num2str(PCACoefficients(4,10)));
set(handles.et_Ch20_Ch11coeff,'String',num2str(PCACoefficients(4,11)));
set(handles.et_Ch20_Ch12coeff,'String',num2str(PCACoefficients(4,12)));
set(handles.et_Ch20_Ch13coeff,'String',num2str(PCACoefficients(4,13)));
set(handles.et_Ch20_Ch14coeff,'String',num2str(PCACoefficients(4,14)));
set(handles.et_Ch20_Ch15coeff,'String',num2str(PCACoefficients(4,15)));
set(handles.et_Ch20_Ch16coeff,'String',num2str(PCACoefficients(4,16)));

set(handles.et_Ch21_Ch1coeff,'String',num2str(PCACoefficients(5,1)));
set(handles.et_Ch21_Ch2coeff,'String',num2str(PCACoefficients(5,2)));
set(handles.et_Ch21_Ch3coeff,'String',num2str(PCACoefficients(5,3)));
set(handles.et_Ch21_Ch4coeff,'String',num2str(PCACoefficients(5,4)));
set(handles.et_Ch21_Ch5coeff,'String',num2str(PCACoefficients(5,5)));
set(handles.et_Ch21_Ch6coeff,'String',num2str(PCACoefficients(5,6)));
set(handles.et_Ch21_Ch7coeff,'String',num2str(PCACoefficients(5,7)));
set(handles.et_Ch21_Ch8coeff,'String',num2str(PCACoefficients(5,8)));
set(handles.et_Ch21_Ch9coeff,'String',num2str(PCACoefficients(5,9)));
set(handles.et_Ch21_Ch10coeff,'String',num2str(PCACoefficients(5,10)));
set(handles.et_Ch21_Ch11coeff,'String',num2str(PCACoefficients(5,11)));
set(handles.et_Ch21_Ch12coeff,'String',num2str(PCACoefficients(5,12)));
set(handles.et_Ch21_Ch13coeff,'String',num2str(PCACoefficients(5,13)));
set(handles.et_Ch21_Ch14coeff,'String',num2str(PCACoefficients(5,14)));
set(handles.et_Ch21_Ch15coeff,'String',num2str(PCACoefficients(5,15)));
set(handles.et_Ch21_Ch16coeff,'String',num2str(PCACoefficients(5,16)));

set(handles.et_Ch22_Ch1coeff,'String',num2str(PCACoefficients(6,1)));
set(handles.et_Ch22_Ch2coeff,'String',num2str(PCACoefficients(6,2)));
set(handles.et_Ch22_Ch3coeff,'String',num2str(PCACoefficients(6,3)));
set(handles.et_Ch22_Ch4coeff,'String',num2str(PCACoefficients(6,4)));
set(handles.et_Ch22_Ch5coeff,'String',num2str(PCACoefficients(6,5)));
set(handles.et_Ch22_Ch6coeff,'String',num2str(PCACoefficients(6,6)));
set(handles.et_Ch22_Ch7coeff,'String',num2str(PCACoefficients(6,7)));
set(handles.et_Ch22_Ch8coeff,'String',num2str(PCACoefficients(6,8)));
set(handles.et_Ch22_Ch9coeff,'String',num2str(PCACoefficients(6,9)));
set(handles.et_Ch22_Ch10coeff,'String',num2str(PCACoefficients(6,10)));
set(handles.et_Ch22_Ch11coeff,'String',num2str(PCACoefficients(6,11)));
set(handles.et_Ch22_Ch12coeff,'String',num2str(PCACoefficients(6,12)));
set(handles.et_Ch22_Ch13coeff,'String',num2str(PCACoefficients(6,13)));
set(handles.et_Ch22_Ch14coeff,'String',num2str(PCACoefficients(6,14)));
set(handles.et_Ch22_Ch15coeff,'String',num2str(PCACoefficients(6,15)));
set(handles.et_Ch22_Ch16coeff,'String',num2str(PCACoefficients(6,16)));

set(handles.et_Ch23_Ch1coeff,'String',num2str(PCACoefficients(7,1)));
set(handles.et_Ch23_Ch2coeff,'String',num2str(PCACoefficients(7,2)));
set(handles.et_Ch23_Ch3coeff,'String',num2str(PCACoefficients(7,3)));
set(handles.et_Ch23_Ch4coeff,'String',num2str(PCACoefficients(7,4)));
set(handles.et_Ch23_Ch5coeff,'String',num2str(PCACoefficients(7,5)));
set(handles.et_Ch23_Ch6coeff,'String',num2str(PCACoefficients(7,6)));
set(handles.et_Ch23_Ch7coeff,'String',num2str(PCACoefficients(7,7)));
set(handles.et_Ch23_Ch8coeff,'String',num2str(PCACoefficients(7,8)));
set(handles.et_Ch23_Ch9coeff,'String',num2str(PCACoefficients(7,9)));
set(handles.et_Ch23_Ch10coeff,'String',num2str(PCACoefficients(7,10)));
set(handles.et_Ch23_Ch11coeff,'String',num2str(PCACoefficients(7,11)));
set(handles.et_Ch23_Ch12coeff,'String',num2str(PCACoefficients(7,12)));
set(handles.et_Ch23_Ch13coeff,'String',num2str(PCACoefficients(7,13)));
set(handles.et_Ch23_Ch14coeff,'String',num2str(PCACoefficients(7,14)));
set(handles.et_Ch23_Ch15coeff,'String',num2str(PCACoefficients(7,15)));
set(handles.et_Ch23_Ch16coeff,'String',num2str(PCACoefficients(7,16)));

set(handles.et_Ch24_Ch1coeff,'String',num2str(PCACoefficients(8,1)));
set(handles.et_Ch24_Ch2coeff,'String',num2str(PCACoefficients(8,2)));
set(handles.et_Ch24_Ch3coeff,'String',num2str(PCACoefficients(8,3)));
set(handles.et_Ch24_Ch4coeff,'String',num2str(PCACoefficients(8,4)));
set(handles.et_Ch24_Ch5coeff,'String',num2str(PCACoefficients(8,5)));
set(handles.et_Ch24_Ch6coeff,'String',num2str(PCACoefficients(8,6)));
set(handles.et_Ch24_Ch7coeff,'String',num2str(PCACoefficients(8,7)));
set(handles.et_Ch24_Ch8coeff,'String',num2str(PCACoefficients(8,8)));
set(handles.et_Ch24_Ch9coeff,'String',num2str(PCACoefficients(8,9)));
set(handles.et_Ch24_Ch10coeff,'String',num2str(PCACoefficients(8,10)));
set(handles.et_Ch24_Ch11coeff,'String',num2str(PCACoefficients(8,11)));
set(handles.et_Ch24_Ch12coeff,'String',num2str(PCACoefficients(8,12)));
set(handles.et_Ch24_Ch13coeff,'String',num2str(PCACoefficients(8,13)));
set(handles.et_Ch24_Ch14coeff,'String',num2str(PCACoefficients(8,14)));
set(handles.et_Ch24_Ch15coeff,'String',num2str(PCACoefficients(8,15)));
set(handles.et_Ch24_Ch16coeff,'String',num2str(PCACoefficients(8,16)));

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
        if (~exist('PCACoefficients','var'))
            disp('Not a valid file');
            errordlg('Not a valid file','Error');
            return;
        end
    else
        disp('Not a valid file');
        errordlg('Not a valid file','Error');
        return;
    end
end
% check dimensions
[m n] = size(PCACoefficients);
if m~=8 && n~=16
    disp('Not a valid matrix');
    errordlg('Not a valid matrix','Error');
    return;
end

set(handles.et_Ch17_Ch1coeff,'String',num2str(PCACoefficients(1,1)));
set(handles.et_Ch17_Ch2coeff,'String',num2str(PCACoefficients(1,2)));
set(handles.et_Ch17_Ch3coeff,'String',num2str(PCACoefficients(1,3)));
set(handles.et_Ch17_Ch4coeff,'String',num2str(PCACoefficients(1,4)));
set(handles.et_Ch17_Ch5coeff,'String',num2str(PCACoefficients(1,5)));
set(handles.et_Ch17_Ch6coeff,'String',num2str(PCACoefficients(1,6)));
set(handles.et_Ch17_Ch7coeff,'String',num2str(PCACoefficients(1,7)));
set(handles.et_Ch17_Ch8coeff,'String',num2str(PCACoefficients(1,8)));
set(handles.et_Ch17_Ch9coeff,'String',num2str(PCACoefficients(1,9)));
set(handles.et_Ch17_Ch10coeff,'String',num2str(PCACoefficients(1,10)));
set(handles.et_Ch17_Ch11coeff,'String',num2str(PCACoefficients(1,11)));
set(handles.et_Ch17_Ch12coeff,'String',num2str(PCACoefficients(1,12)));
set(handles.et_Ch17_Ch13coeff,'String',num2str(PCACoefficients(1,13)));
set(handles.et_Ch17_Ch14coeff,'String',num2str(PCACoefficients(1,14)));
set(handles.et_Ch17_Ch15coeff,'String',num2str(PCACoefficients(1,15)));
set(handles.et_Ch17_Ch16coeff,'String',num2str(PCACoefficients(1,16)));

set(handles.et_Ch18_Ch1coeff,'String',num2str(PCACoefficients(2,1)));
set(handles.et_Ch18_Ch2coeff,'String',num2str(PCACoefficients(2,2)));
set(handles.et_Ch18_Ch3coeff,'String',num2str(PCACoefficients(2,3)));
set(handles.et_Ch18_Ch4coeff,'String',num2str(PCACoefficients(2,4)));
set(handles.et_Ch18_Ch5coeff,'String',num2str(PCACoefficients(2,5)));
set(handles.et_Ch18_Ch6coeff,'String',num2str(PCACoefficients(2,6)));
set(handles.et_Ch18_Ch7coeff,'String',num2str(PCACoefficients(2,7)));
set(handles.et_Ch18_Ch8coeff,'String',num2str(PCACoefficients(2,8)));
set(handles.et_Ch18_Ch9coeff,'String',num2str(PCACoefficients(2,9)));
set(handles.et_Ch18_Ch10coeff,'String',num2str(PCACoefficients(2,10)));
set(handles.et_Ch18_Ch11coeff,'String',num2str(PCACoefficients(2,11)));
set(handles.et_Ch18_Ch12coeff,'String',num2str(PCACoefficients(2,12)));
set(handles.et_Ch18_Ch13coeff,'String',num2str(PCACoefficients(2,13)));
set(handles.et_Ch18_Ch14coeff,'String',num2str(PCACoefficients(2,14)));
set(handles.et_Ch18_Ch15coeff,'String',num2str(PCACoefficients(2,15)));
set(handles.et_Ch18_Ch16coeff,'String',num2str(PCACoefficients(2,16)));

set(handles.et_Ch19_Ch1coeff,'String',num2str(PCACoefficients(3,1)));
set(handles.et_Ch19_Ch2coeff,'String',num2str(PCACoefficients(3,2)));
set(handles.et_Ch19_Ch3coeff,'String',num2str(PCACoefficients(3,3)));
set(handles.et_Ch19_Ch4coeff,'String',num2str(PCACoefficients(3,4)));
set(handles.et_Ch19_Ch5coeff,'String',num2str(PCACoefficients(3,5)));
set(handles.et_Ch19_Ch6coeff,'String',num2str(PCACoefficients(3,6)));
set(handles.et_Ch19_Ch7coeff,'String',num2str(PCACoefficients(3,7)));
set(handles.et_Ch19_Ch8coeff,'String',num2str(PCACoefficients(3,8)));
set(handles.et_Ch19_Ch9coeff,'String',num2str(PCACoefficients(3,9)));
set(handles.et_Ch19_Ch10coeff,'String',num2str(PCACoefficients(3,10)));
set(handles.et_Ch19_Ch11coeff,'String',num2str(PCACoefficients(3,11)));
set(handles.et_Ch19_Ch12coeff,'String',num2str(PCACoefficients(3,12)));
set(handles.et_Ch19_Ch13coeff,'String',num2str(PCACoefficients(3,13)));
set(handles.et_Ch19_Ch14coeff,'String',num2str(PCACoefficients(3,14)));
set(handles.et_Ch19_Ch15coeff,'String',num2str(PCACoefficients(3,15)));
set(handles.et_Ch19_Ch16coeff,'String',num2str(PCACoefficients(3,16)));

set(handles.et_Ch20_Ch1coeff,'String',num2str(PCACoefficients(4,1)));
set(handles.et_Ch20_Ch2coeff,'String',num2str(PCACoefficients(4,2)));
set(handles.et_Ch20_Ch3coeff,'String',num2str(PCACoefficients(4,3)));
set(handles.et_Ch20_Ch4coeff,'String',num2str(PCACoefficients(4,4)));
set(handles.et_Ch20_Ch5coeff,'String',num2str(PCACoefficients(4,5)));
set(handles.et_Ch20_Ch6coeff,'String',num2str(PCACoefficients(4,6)));
set(handles.et_Ch20_Ch7coeff,'String',num2str(PCACoefficients(4,7)));
set(handles.et_Ch20_Ch8coeff,'String',num2str(PCACoefficients(4,8)));
set(handles.et_Ch20_Ch9coeff,'String',num2str(PCACoefficients(4,9)));
set(handles.et_Ch20_Ch10coeff,'String',num2str(PCACoefficients(4,10)));
set(handles.et_Ch20_Ch11coeff,'String',num2str(PCACoefficients(4,11)));
set(handles.et_Ch20_Ch12coeff,'String',num2str(PCACoefficients(4,12)));
set(handles.et_Ch20_Ch13coeff,'String',num2str(PCACoefficients(4,13)));
set(handles.et_Ch20_Ch14coeff,'String',num2str(PCACoefficients(4,14)));
set(handles.et_Ch20_Ch15coeff,'String',num2str(PCACoefficients(4,15)));
set(handles.et_Ch20_Ch16coeff,'String',num2str(PCACoefficients(4,16)));

set(handles.et_Ch21_Ch1coeff,'String',num2str(PCACoefficients(5,1)));
set(handles.et_Ch21_Ch2coeff,'String',num2str(PCACoefficients(5,2)));
set(handles.et_Ch21_Ch3coeff,'String',num2str(PCACoefficients(5,3)));
set(handles.et_Ch21_Ch4coeff,'String',num2str(PCACoefficients(5,4)));
set(handles.et_Ch21_Ch5coeff,'String',num2str(PCACoefficients(5,5)));
set(handles.et_Ch21_Ch6coeff,'String',num2str(PCACoefficients(5,6)));
set(handles.et_Ch21_Ch7coeff,'String',num2str(PCACoefficients(5,7)));
set(handles.et_Ch21_Ch8coeff,'String',num2str(PCACoefficients(5,8)));
set(handles.et_Ch21_Ch9coeff,'String',num2str(PCACoefficients(5,9)));
set(handles.et_Ch21_Ch10coeff,'String',num2str(PCACoefficients(5,10)));
set(handles.et_Ch21_Ch11coeff,'String',num2str(PCACoefficients(5,11)));
set(handles.et_Ch21_Ch12coeff,'String',num2str(PCACoefficients(5,12)));
set(handles.et_Ch21_Ch13coeff,'String',num2str(PCACoefficients(5,13)));
set(handles.et_Ch21_Ch14coeff,'String',num2str(PCACoefficients(5,14)));
set(handles.et_Ch21_Ch15coeff,'String',num2str(PCACoefficients(5,15)));
set(handles.et_Ch21_Ch16coeff,'String',num2str(PCACoefficients(5,16)));

set(handles.et_Ch22_Ch1coeff,'String',num2str(PCACoefficients(6,1)));
set(handles.et_Ch22_Ch2coeff,'String',num2str(PCACoefficients(6,2)));
set(handles.et_Ch22_Ch3coeff,'String',num2str(PCACoefficients(6,3)));
set(handles.et_Ch22_Ch4coeff,'String',num2str(PCACoefficients(6,4)));
set(handles.et_Ch22_Ch5coeff,'String',num2str(PCACoefficients(6,5)));
set(handles.et_Ch22_Ch6coeff,'String',num2str(PCACoefficients(6,6)));
set(handles.et_Ch22_Ch7coeff,'String',num2str(PCACoefficients(6,7)));
set(handles.et_Ch22_Ch8coeff,'String',num2str(PCACoefficients(6,8)));
set(handles.et_Ch22_Ch9coeff,'String',num2str(PCACoefficients(6,9)));
set(handles.et_Ch22_Ch10coeff,'String',num2str(PCACoefficients(6,10)));
set(handles.et_Ch22_Ch11coeff,'String',num2str(PCACoefficients(6,11)));
set(handles.et_Ch22_Ch12coeff,'String',num2str(PCACoefficients(6,12)));
set(handles.et_Ch22_Ch13coeff,'String',num2str(PCACoefficients(6,13)));
set(handles.et_Ch22_Ch14coeff,'String',num2str(PCACoefficients(6,14)));
set(handles.et_Ch22_Ch15coeff,'String',num2str(PCACoefficients(6,15)));
set(handles.et_Ch22_Ch16coeff,'String',num2str(PCACoefficients(6,16)));

set(handles.et_Ch23_Ch1coeff,'String',num2str(PCACoefficients(7,1)));
set(handles.et_Ch23_Ch2coeff,'String',num2str(PCACoefficients(7,2)));
set(handles.et_Ch23_Ch3coeff,'String',num2str(PCACoefficients(7,3)));
set(handles.et_Ch23_Ch4coeff,'String',num2str(PCACoefficients(7,4)));
set(handles.et_Ch23_Ch5coeff,'String',num2str(PCACoefficients(7,5)));
set(handles.et_Ch23_Ch6coeff,'String',num2str(PCACoefficients(7,6)));
set(handles.et_Ch23_Ch7coeff,'String',num2str(PCACoefficients(7,7)));
set(handles.et_Ch23_Ch8coeff,'String',num2str(PCACoefficients(7,8)));
set(handles.et_Ch23_Ch9coeff,'String',num2str(PCACoefficients(7,9)));
set(handles.et_Ch23_Ch10coeff,'String',num2str(PCACoefficients(7,10)));
set(handles.et_Ch23_Ch11coeff,'String',num2str(PCACoefficients(7,11)));
set(handles.et_Ch23_Ch12coeff,'String',num2str(PCACoefficients(7,12)));
set(handles.et_Ch23_Ch13coeff,'String',num2str(PCACoefficients(7,13)));
set(handles.et_Ch23_Ch14coeff,'String',num2str(PCACoefficients(7,14)));
set(handles.et_Ch23_Ch15coeff,'String',num2str(PCACoefficients(7,15)));
set(handles.et_Ch23_Ch16coeff,'String',num2str(PCACoefficients(7,16)));

set(handles.et_Ch24_Ch1coeff,'String',num2str(PCACoefficients(8,1)));
set(handles.et_Ch24_Ch2coeff,'String',num2str(PCACoefficients(8,2)));
set(handles.et_Ch24_Ch3coeff,'String',num2str(PCACoefficients(8,3)));
set(handles.et_Ch24_Ch4coeff,'String',num2str(PCACoefficients(8,4)));
set(handles.et_Ch24_Ch5coeff,'String',num2str(PCACoefficients(8,5)));
set(handles.et_Ch24_Ch6coeff,'String',num2str(PCACoefficients(8,6)));
set(handles.et_Ch24_Ch7coeff,'String',num2str(PCACoefficients(8,7)));
set(handles.et_Ch24_Ch8coeff,'String',num2str(PCACoefficients(8,8)));
set(handles.et_Ch24_Ch9coeff,'String',num2str(PCACoefficients(8,9)));
set(handles.et_Ch24_Ch10coeff,'String',num2str(PCACoefficients(8,10)));
set(handles.et_Ch24_Ch11coeff,'String',num2str(PCACoefficients(8,11)));
set(handles.et_Ch24_Ch12coeff,'String',num2str(PCACoefficients(8,12)));
set(handles.et_Ch24_Ch13coeff,'String',num2str(PCACoefficients(8,13)));
set(handles.et_Ch24_Ch14coeff,'String',num2str(PCACoefficients(8,14)));
set(handles.et_Ch24_Ch15coeff,'String',num2str(PCACoefficients(8,15)));
set(handles.et_Ch24_Ch16coeff,'String',num2str(PCACoefficients(8,16)));
    

% --------------------------------------------------------------------
function menu_save_Callback(hObject, eventdata, handles)
% hObject    handle to menu_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

PCACoefficients = zeros(8,16);

PCACoefficients(1,1) = str2double(get(handles.et_Ch17_Ch1coeff,'String'));
PCACoefficients(1,2) = str2double(get(handles.et_Ch17_Ch2coeff,'String'));
PCACoefficients(1,3) = str2double(get(handles.et_Ch17_Ch3coeff,'String'));
PCACoefficients(1,4) = str2double(get(handles.et_Ch17_Ch4coeff,'String'));
PCACoefficients(1,5) = str2double(get(handles.et_Ch17_Ch5coeff,'String'));
PCACoefficients(1,6) = str2double(get(handles.et_Ch17_Ch6coeff,'String'));
PCACoefficients(1,7) = str2double(get(handles.et_Ch17_Ch7coeff,'String'));
PCACoefficients(1,8) = str2double(get(handles.et_Ch17_Ch8coeff,'String'));
PCACoefficients(1,9) = str2double(get(handles.et_Ch17_Ch9coeff,'String'));
PCACoefficients(1,10) = str2double(get(handles.et_Ch17_Ch10coeff,'String'));
PCACoefficients(1,11) = str2double(get(handles.et_Ch17_Ch11coeff,'String'));
PCACoefficients(1,12) = str2double(get(handles.et_Ch17_Ch12coeff,'String'));
PCACoefficients(1,13) = str2double(get(handles.et_Ch17_Ch13coeff,'String'));
PCACoefficients(1,14) = str2double(get(handles.et_Ch17_Ch14coeff,'String'));
PCACoefficients(1,15) = str2double(get(handles.et_Ch17_Ch15coeff,'String'));
PCACoefficients(1,16) = str2double(get(handles.et_Ch17_Ch16coeff,'String'));

PCACoefficients(2,1) = str2double(get(handles.et_Ch18_Ch1coeff,'String'));
PCACoefficients(2,2) = str2double(get(handles.et_Ch18_Ch2coeff,'String'));
PCACoefficients(2,3) = str2double(get(handles.et_Ch18_Ch3coeff,'String'));
PCACoefficients(2,4) = str2double(get(handles.et_Ch18_Ch4coeff,'String'));
PCACoefficients(2,5) = str2double(get(handles.et_Ch18_Ch5coeff,'String'));
PCACoefficients(2,6) = str2double(get(handles.et_Ch18_Ch6coeff,'String'));
PCACoefficients(2,7) = str2double(get(handles.et_Ch18_Ch7coeff,'String'));
PCACoefficients(2,8) = str2double(get(handles.et_Ch18_Ch8coeff,'String'));
PCACoefficients(2,9) = str2double(get(handles.et_Ch18_Ch9coeff,'String'));
PCACoefficients(2,10) = str2double(get(handles.et_Ch18_Ch10coeff,'String'));
PCACoefficients(2,11) = str2double(get(handles.et_Ch18_Ch11coeff,'String'));
PCACoefficients(2,12) = str2double(get(handles.et_Ch18_Ch12coeff,'String'));
PCACoefficients(2,13) = str2double(get(handles.et_Ch18_Ch13coeff,'String'));
PCACoefficients(2,14) = str2double(get(handles.et_Ch18_Ch14coeff,'String'));
PCACoefficients(2,15) = str2double(get(handles.et_Ch18_Ch15coeff,'String'));
PCACoefficients(2,16) = str2double(get(handles.et_Ch18_Ch16coeff,'String'));

PCACoefficients(3,1) = str2double(get(handles.et_Ch19_Ch1coeff,'String'));
PCACoefficients(3,2) = str2double(get(handles.et_Ch19_Ch2coeff,'String'));
PCACoefficients(3,3) = str2double(get(handles.et_Ch19_Ch3coeff,'String'));
PCACoefficients(3,4) = str2double(get(handles.et_Ch19_Ch4coeff,'String'));
PCACoefficients(3,5) = str2double(get(handles.et_Ch19_Ch5coeff,'String'));
PCACoefficients(3,6) = str2double(get(handles.et_Ch19_Ch6coeff,'String'));
PCACoefficients(3,7) = str2double(get(handles.et_Ch19_Ch7coeff,'String'));
PCACoefficients(3,8) = str2double(get(handles.et_Ch19_Ch8coeff,'String'));
PCACoefficients(3,9) = str2double(get(handles.et_Ch19_Ch9coeff,'String'));
PCACoefficients(3,10) = str2double(get(handles.et_Ch19_Ch10coeff,'String'));
PCACoefficients(3,11) = str2double(get(handles.et_Ch19_Ch11coeff,'String'));
PCACoefficients(3,12) = str2double(get(handles.et_Ch19_Ch12coeff,'String'));
PCACoefficients(3,13) = str2double(get(handles.et_Ch19_Ch13coeff,'String'));
PCACoefficients(3,14) = str2double(get(handles.et_Ch19_Ch14coeff,'String'));
PCACoefficients(3,15) = str2double(get(handles.et_Ch19_Ch15coeff,'String'));
PCACoefficients(3,16) = str2double(get(handles.et_Ch19_Ch16coeff,'String'));

PCACoefficients(4,1) = str2double(get(handles.et_Ch20_Ch1coeff,'String'));
PCACoefficients(4,2) = str2double(get(handles.et_Ch20_Ch2coeff,'String'));
PCACoefficients(4,3) = str2double(get(handles.et_Ch20_Ch3coeff,'String'));
PCACoefficients(4,4) = str2double(get(handles.et_Ch20_Ch4coeff,'String'));
PCACoefficients(4,5) = str2double(get(handles.et_Ch20_Ch5coeff,'String'));
PCACoefficients(4,6) = str2double(get(handles.et_Ch20_Ch6coeff,'String'));
PCACoefficients(4,7) = str2double(get(handles.et_Ch20_Ch7coeff,'String'));
PCACoefficients(4,8) = str2double(get(handles.et_Ch20_Ch8coeff,'String'));
PCACoefficients(4,9) = str2double(get(handles.et_Ch20_Ch9coeff,'String'));
PCACoefficients(4,10) = str2double(get(handles.et_Ch20_Ch10coeff,'String'));
PCACoefficients(4,11) = str2double(get(handles.et_Ch20_Ch11coeff,'String'));
PCACoefficients(4,12) = str2double(get(handles.et_Ch20_Ch12coeff,'String'));
PCACoefficients(4,13) = str2double(get(handles.et_Ch20_Ch13coeff,'String'));
PCACoefficients(4,14) = str2double(get(handles.et_Ch20_Ch14coeff,'String'));
PCACoefficients(4,15) = str2double(get(handles.et_Ch20_Ch15coeff,'String'));
PCACoefficients(4,16) = str2double(get(handles.et_Ch20_Ch16coeff,'String'));

PCACoefficients(5,1) = str2double(get(handles.et_Ch21_Ch1coeff,'String'));
PCACoefficients(5,2) = str2double(get(handles.et_Ch21_Ch2coeff,'String'));
PCACoefficients(5,3) = str2double(get(handles.et_Ch21_Ch3coeff,'String'));
PCACoefficients(5,4) = str2double(get(handles.et_Ch21_Ch4coeff,'String'));
PCACoefficients(5,5) = str2double(get(handles.et_Ch21_Ch5coeff,'String'));
PCACoefficients(5,6) = str2double(get(handles.et_Ch21_Ch6coeff,'String'));
PCACoefficients(5,7) = str2double(get(handles.et_Ch21_Ch7coeff,'String'));
PCACoefficients(5,8) = str2double(get(handles.et_Ch21_Ch8coeff,'String'));
PCACoefficients(5,9) = str2double(get(handles.et_Ch21_Ch9coeff,'String'));
PCACoefficients(5,10) = str2double(get(handles.et_Ch21_Ch10coeff,'String'));
PCACoefficients(5,11) = str2double(get(handles.et_Ch21_Ch11coeff,'String'));
PCACoefficients(5,12) = str2double(get(handles.et_Ch21_Ch12coeff,'String'));
PCACoefficients(5,13) = str2double(get(handles.et_Ch21_Ch13coeff,'String'));
PCACoefficients(5,14) = str2double(get(handles.et_Ch21_Ch14coeff,'String'));
PCACoefficients(5,15) = str2double(get(handles.et_Ch21_Ch15coeff,'String'));
PCACoefficients(5,16) = str2double(get(handles.et_Ch21_Ch16coeff,'String'));

PCACoefficients(6,1) = str2double(get(handles.et_Ch22_Ch1coeff,'String'));
PCACoefficients(6,2) = str2double(get(handles.et_Ch22_Ch2coeff,'String'));
PCACoefficients(6,3) = str2double(get(handles.et_Ch22_Ch3coeff,'String'));
PCACoefficients(6,4) = str2double(get(handles.et_Ch22_Ch4coeff,'String'));
PCACoefficients(6,5) = str2double(get(handles.et_Ch22_Ch5coeff,'String'));
PCACoefficients(6,6) = str2double(get(handles.et_Ch22_Ch6coeff,'String'));
PCACoefficients(6,7) = str2double(get(handles.et_Ch22_Ch7coeff,'String'));
PCACoefficients(6,8) = str2double(get(handles.et_Ch22_Ch8coeff,'String'));
PCACoefficients(6,9) = str2double(get(handles.et_Ch22_Ch9coeff,'String'));
PCACoefficients(6,10) = str2double(get(handles.et_Ch22_Ch10coeff,'String'));
PCACoefficients(6,11) = str2double(get(handles.et_Ch22_Ch11coeff,'String'));
PCACoefficients(6,12) = str2double(get(handles.et_Ch22_Ch12coeff,'String'));
PCACoefficients(6,13) = str2double(get(handles.et_Ch22_Ch13coeff,'String'));
PCACoefficients(6,14) = str2double(get(handles.et_Ch22_Ch14coeff,'String'));
PCACoefficients(6,15) = str2double(get(handles.et_Ch22_Ch15coeff,'String'));
PCACoefficients(6,16) = str2double(get(handles.et_Ch22_Ch16coeff,'String'));

PCACoefficients(7,1) = str2double(get(handles.et_Ch23_Ch1coeff,'String'));
PCACoefficients(7,2) = str2double(get(handles.et_Ch23_Ch2coeff,'String'));
PCACoefficients(7,3) = str2double(get(handles.et_Ch23_Ch3coeff,'String'));
PCACoefficients(7,4) = str2double(get(handles.et_Ch23_Ch4coeff,'String'));
PCACoefficients(7,5) = str2double(get(handles.et_Ch23_Ch5coeff,'String'));
PCACoefficients(7,6) = str2double(get(handles.et_Ch23_Ch6coeff,'String'));
PCACoefficients(7,7) = str2double(get(handles.et_Ch23_Ch7coeff,'String'));
PCACoefficients(7,8) = str2double(get(handles.et_Ch23_Ch8coeff,'String'));
PCACoefficients(7,9) = str2double(get(handles.et_Ch23_Ch9coeff,'String'));
PCACoefficients(7,10) = str2double(get(handles.et_Ch23_Ch10coeff,'String'));
PCACoefficients(7,11) = str2double(get(handles.et_Ch23_Ch11coeff,'String'));
PCACoefficients(7,12) = str2double(get(handles.et_Ch23_Ch12coeff,'String'));
PCACoefficients(7,13) = str2double(get(handles.et_Ch23_Ch13coeff,'String'));
PCACoefficients(7,14) = str2double(get(handles.et_Ch23_Ch14coeff,'String'));
PCACoefficients(7,15) = str2double(get(handles.et_Ch23_Ch15coeff,'String'));
PCACoefficients(7,16) = str2double(get(handles.et_Ch23_Ch16coeff,'String'));

PCACoefficients(8,1) = str2double(get(handles.et_Ch24_Ch1coeff,'String'));
PCACoefficients(8,2) = str2double(get(handles.et_Ch24_Ch2coeff,'String'));
PCACoefficients(8,3) = str2double(get(handles.et_Ch24_Ch3coeff,'String'));
PCACoefficients(8,4) = str2double(get(handles.et_Ch24_Ch4coeff,'String'));
PCACoefficients(8,5) = str2double(get(handles.et_Ch24_Ch5coeff,'String'));
PCACoefficients(8,6) = str2double(get(handles.et_Ch24_Ch6coeff,'String'));
PCACoefficients(8,7) = str2double(get(handles.et_Ch24_Ch7coeff,'String'));
PCACoefficients(8,8) = str2double(get(handles.et_Ch24_Ch8coeff,'String'));
PCACoefficients(8,9) = str2double(get(handles.et_Ch24_Ch9coeff,'String'));
PCACoefficients(8,10) = str2double(get(handles.et_Ch24_Ch10coeff,'String'));
PCACoefficients(8,11) = str2double(get(handles.et_Ch24_Ch11coeff,'String'));
PCACoefficients(8,12) = str2double(get(handles.et_Ch24_Ch12coeff,'String'));
PCACoefficients(8,13) = str2double(get(handles.et_Ch24_Ch13coeff,'String'));
PCACoefficients(8,14) = str2double(get(handles.et_Ch24_Ch14coeff,'String'));
PCACoefficients(8,15) = str2double(get(handles.et_Ch24_Ch15coeff,'String'));
PCACoefficients(8,16) = str2double(get(handles.et_Ch24_Ch16coeff,'String'));

save('PCACoefficients.mat','PCACoefficients');
set(handles.t_msg,'String','Matrix stored in .mat file');
