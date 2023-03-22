function varargout = GUI_MagnetSelection(varargin)
% GUI_MAGNETSELECTION MATLAB code for GUI_MagnetSelection.fig
%      GUI_MAGNETSELECTION, by itself, creates a new GUI_MAGNETSELECTION or raises the existing
%      singleton*.
%
%      H = GUI_MAGNETSELECTION returns the handle to a new GUI_MAGNETSELECTION or the handle to
%      the existing singleton*.
%
%      GUI_MAGNETSELECTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_MAGNETSELECTION.M with the given input arguments.
%
%      GUI_MAGNETSELECTION('Property','Value',...) creates a new GUI_MAGNETSELECTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_MagnetSelection_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_MagnetSelection_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_MagnetSelection

% Last Modified by GUIDE v2.5 14-Mar-2023 15:27:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_MagnetSelection_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_MagnetSelection_OutputFcn, ...
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


% --- Executes just before GUI_MagnetSelection is made visible.
function GUI_MagnetSelection_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_MagnetSelection (see VARARGIN)

% Choose default command line output for GUI_MagnetSelection
handles.output = hObject;

movegui(hObject,'center');
% Update handles structure
guidata(hObject, handles);


% UIWAIT makes GUI_MagnetSelection wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_MagnetSelection_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function et_mag1Ch1_Callback(hObject, eventdata, handles)
% hObject    handle to et_mag1Ch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_mag1Ch1 as text
%        str2double(get(hObject,'String')) returns contents of et_mag1Ch1 as a double


% --- Executes during object creation, after setting all properties.
function et_mag1Ch1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_mag1Ch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_mag1Ch2_Callback(hObject, eventdata, handles)
% hObject    handle to et_mag1Ch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_mag1Ch2 as text
%        str2double(get(hObject,'String')) returns contents of et_mag1Ch2 as a double


% --- Executes during object creation, after setting all properties.
function et_mag1Ch2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_mag1Ch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function et_mag1Ch3_Callback(hObject, eventdata, handles)
% hObject    handle to et_mag1Ch3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_mag1Ch3 as text
%        str2double(get(hObject,'String')) returns contents of et_mag1Ch3 as a double


% --- Executes during object creation, after setting all properties.
function et_mag1Ch3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_mag1Ch3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function et_mag1Ch4_Callback(hObject, eventdata, handles)
% hObject    handle to et_mag1Ch4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_mag1Ch4 as text
%        str2double(get(hObject,'String')) returns contents of et_mag1Ch4 as a double


% --- Executes during object creation, after setting all properties.
function et_mag1Ch4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_mag1Ch4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function et_mag1Ch5_Callback(hObject, eventdata, handles)
% hObject    handle to et_mag1Ch5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_mag1Ch5 as text
%        str2double(get(hObject,'String')) returns contents of et_mag1Ch5 as a double

% --- Executes during object creation, after setting all properties.
function et_mag1Ch5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_mag1Ch5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function et_mag1Ch6_Callback(hObject, eventdata, handles)
% hObject    handle to et_mag1Ch6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_mag1Ch6 as text
%        str2double(get(hObject,'String')) returns contents of et_mag1Ch6 as a double


% --- Executes during object creation, after setting all properties.
function et_mag1Ch6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_mag1Ch6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_mag1Ch7_Callback(hObject, eventdata, handles)
% hObject    handle to et_mag1Ch7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_mag1Ch7 as text
%        str2double(get(hObject,'String')) returns contents of et_mag1Ch7 as a double


% --- Executes during object creation, after setting all properties.
function et_mag1Ch7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_mag1Ch7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_mag1Ch8_Callback(hObject, eventdata, handles)
% hObject    handle to et_mag1Ch8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_mag1Ch8 as text
%        str2double(get(hObject,'String')) returns contents of et_mag1Ch8 as a double


% --- Executes during object creation, after setting all properties.
function et_mag1Ch8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_mag1Ch8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_mag1Ch9_Callback(hObject, eventdata, handles)
% hObject    handle to et_mag1Ch9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_mag1Ch9 as text
%        str2double(get(hObject,'String')) returns contents of et_mag1Ch9 as a double


% --- Executes during object creation, after setting all properties.
function et_mag1Ch9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_mag1Ch9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_mag2Ch1_Callback(hObject, eventdata, handles)
% hObject    handle to et_mag2Ch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_mag2Ch1 as text
%        str2double(get(hObject,'String')) returns contents of et_mag2Ch1 as a double


% --- Executes during object creation, after setting all properties.
function et_mag2Ch1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_mag2Ch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function et_mag2Ch2_Callback(hObject, eventdata, handles)
% hObject    handle to et_mag2Ch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_mag2Ch2 as text
%        str2double(get(hObject,'String')) returns contents of et_mag2Ch2 as a double


% --- Executes during object creation, after setting all properties.
function et_mag2Ch2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_mag2Ch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function et_mag2Ch3_Callback(hObject, eventdata, handles)
% hObject    handle to et_mag2Ch3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_mag2Ch3 as text
%        str2double(get(hObject,'String')) returns contents of et_mag2Ch3 as a double


% --- Executes during object creation, after setting all properties.
function et_mag2Ch3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_mag2Ch3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function et_mag2Ch4_Callback(hObject, eventdata, handles)
% hObject    handle to et_mag2Ch4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_mag2Ch4 as text
%        str2double(get(hObject,'String')) returns contents of et_mag2Ch4 as a double


% --- Executes during object creation, after setting all properties.
function et_mag2Ch4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_mag2Ch4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function et_mag2Ch5_Callback(hObject, eventdata, handles)
% hObject    handle to et_mag2Ch5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_mag2Ch5 as text
%        str2double(get(hObject,'String')) returns contents of et_mag2Ch5 as a double


% --- Executes during object creation, after setting all properties.
function et_mag2Ch5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_mag2Ch5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function et_mag2Ch6_Callback(hObject, eventdata, handles)
% hObject    handle to et_mag2Ch6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_mag2Ch6 as text
%        str2double(get(hObject,'String')) returns contents of et_mag2Ch6 as a double


% --- Executes during object creation, after setting all properties.
function et_mag2Ch6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_mag2Ch6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_mag2Ch7_Callback(hObject, eventdata, handles)
% hObject    handle to et_mag2Ch7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_mag2Ch7 as text
%        str2double(get(hObject,'String')) returns contents of et_mag2Ch7 as a double


% --- Executes during object creation, after setting all properties.
function et_mag2Ch7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_mag2Ch7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_mag2Ch8_Callback(hObject, eventdata, handles)
% hObject    handle to et_mag2Ch8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_mag2Ch8 as text
%        str2double(get(hObject,'String')) returns contents of et_mag2Ch8 as a double


% --- Executes during object creation, after setting all properties.
function et_mag2Ch8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_mag2Ch8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_mag2Ch9_Callback(hObject, eventdata, handles)
% hObject    handle to et_mag2Ch9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_mag2Ch9 as text
%        str2double(get(hObject,'String')) returns contents of et_mag2Ch9 as a double


% --- Executes during object creation, after setting all properties.
function et_mag2Ch9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_mag2Ch9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_magSelec.
function pb_magSelec_Callback(hObject, eventdata, handles)
% hObject    handle to pb_magSelec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    for i = 1:15
        muscle(i,1) = str2double(get(eval(strcat('handles.et_mag1Ch',num2str(i))),'String'));
        muscle(i,2) = str2double(get(eval(strcat('handles.et_mag2Ch',num2str(i))),'String'));
    end
    muscle(all(~muscle,2),:) = [];
    setappdata(0,'muscle',muscle);
    guidata(hObject,handles);
    close(GUI_MagnetSelection);
    


% --- Executes during object creation, after setting all properties.
function t_muscle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t_muscle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function et_mag1Ch10_Callback(hObject, eventdata, handles)
% hObject    handle to et_mag1Ch10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_mag1Ch10 as text
%        str2double(get(hObject,'String')) returns contents of et_mag1Ch10 as a double


% --- Executes during object creation, after setting all properties.
function et_mag1Ch10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_mag1Ch10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_mag2Ch10_Callback(hObject, eventdata, handles)
% hObject    handle to et_mag2Ch10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_mag2Ch10 as text
%        str2double(get(hObject,'String')) returns contents of et_mag2Ch10 as a double


% --- Executes during object creation, after setting all properties.
function et_mag2Ch10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_mag2Ch10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_mag1Ch11_Callback(hObject, eventdata, handles)
% hObject    handle to et_mag1Ch11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_mag1Ch11 as text
%        str2double(get(hObject,'String')) returns contents of et_mag1Ch11 as a double


% --- Executes during object creation, after setting all properties.
function et_mag1Ch11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_mag1Ch11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_mag2Ch11_Callback(hObject, eventdata, handles)
% hObject    handle to et_mag2Ch11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_mag2Ch11 as text
%        str2double(get(hObject,'String')) returns contents of et_mag2Ch11 as a double


% --- Executes during object creation, after setting all properties.
function et_mag2Ch11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_mag2Ch11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_mag1Ch12_Callback(hObject, eventdata, handles)
% hObject    handle to et_mag1Ch12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_mag1Ch12 as text
%        str2double(get(hObject,'String')) returns contents of et_mag1Ch12 as a double


% --- Executes during object creation, after setting all properties.
function et_mag1Ch12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_mag1Ch12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_mag2Ch12_Callback(hObject, eventdata, handles)
% hObject    handle to et_mag2Ch12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_mag2Ch12 as text
%        str2double(get(hObject,'String')) returns contents of et_mag2Ch12 as a double


% --- Executes during object creation, after setting all properties.
function et_mag2Ch12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_mag2Ch12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_mag1Ch13_Callback(hObject, eventdata, handles)
% hObject    handle to et_mag1Ch13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_mag1Ch13 as text
%        str2double(get(hObject,'String')) returns contents of et_mag1Ch13 as a double


% --- Executes during object creation, after setting all properties.
function et_mag1Ch13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_mag1Ch13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_mag2Ch13_Callback(hObject, eventdata, handles)
% hObject    handle to et_mag2Ch13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_mag2Ch13 as text
%        str2double(get(hObject,'String')) returns contents of et_mag2Ch13 as a double


% --- Executes during object creation, after setting all properties.
function et_mag2Ch13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_mag2Ch13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_mag1Ch14_Callback(hObject, eventdata, handles)
% hObject    handle to et_mag1Ch14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_mag1Ch14 as text
%        str2double(get(hObject,'String')) returns contents of et_mag1Ch14 as a double


% --- Executes during object creation, after setting all properties.
function et_mag1Ch14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_mag1Ch14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_mag2Ch14_Callback(hObject, eventdata, handles)
% hObject    handle to et_mag2Ch14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_mag2Ch14 as text
%        str2double(get(hObject,'String')) returns contents of et_mag2Ch14 as a double


% --- Executes during object creation, after setting all properties.
function et_mag2Ch14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_mag2Ch14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_mag1Ch15_Callback(hObject, eventdata, handles)
% hObject    handle to et_mag1Ch15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_mag1Ch15 as text
%        str2double(get(hObject,'String')) returns contents of et_mag1Ch15 as a double


% --- Executes during object creation, after setting all properties.
function et_mag1Ch15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_mag1Ch15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function et_mag2Ch15_Callback(hObject, eventdata, handles)
% hObject    handle to et_mag2Ch15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_mag2Ch15 as text
%        str2double(get(hObject,'String')) returns contents of et_mag2Ch15 as a double


% --- Executes during object creation, after setting all properties.
function et_mag2Ch15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_mag2Ch15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
