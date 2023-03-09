function varargout = GUI_nearToggles(varargin)
% GUI_NEARTOGGLES MATLAB code for GUI_nearToggles.fig
%      GUI_NEARTOGGLES, by itself, creates a new GUI_NEARTOGGLES or raises the existing
%      singleton*.
%
%      H = GUI_NEARTOGGLES returns the handle to a new GUI_NEARTOGGLES or the handle to
%      the existing singleton*.
%
%      GUI_NEARTOGGLES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_NEARTOGGLES.M with the given input arguments.
%
%      GUI_NEARTOGGLES('Property','Value',...) creates a new GUI_NEARTOGGLES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_nearToggles_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_nearToggles_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_nearToggles

% Last Modified by GUIDE v2.5 05-Nov-2019 20:17:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_nearToggles_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_nearToggles_OutputFcn, ...
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


% --- Executes just before GUI_nearToggles is made visible.
function GUI_nearToggles_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_nearToggles (see VARARGIN)

% Choose default command line output for GUI_nearToggles
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_nearToggles wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_nearToggles_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
