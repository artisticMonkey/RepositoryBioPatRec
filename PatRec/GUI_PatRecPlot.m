function varargout = GUI_PatRecPlot(varargin)
% GUI_PATRECPLOT MATLAB code for GUI_PatRecPlot.fig
%      GUI_PATRECPLOT, by itself, creates a new GUI_PATRECPLOT or raises the existing
%      singleton*.
%
%      H = GUI_PATRECPLOT returns the handle to a new GUI_PATRECPLOT or the handle to
%      the existing singleton*.
%
%      GUI_PATRECPLOT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_PATRECPLOT.M with the given input arguments.
%
%      GUI_PATRECPLOT('Property','Value',...) creates a new GUI_PATRECPLOT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_PatRecPlot_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_PatRecPlot_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_PatRecPlot

% Last Modified by GUIDE v2.5 30-Sep-2019 11:02:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_PatRecPlot_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_PatRecPlot_OutputFcn, ...
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


% --- Executes just before GUI_PatRecPlot is made visible.
function GUI_PatRecPlot_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_PatRecPlot (see VARARGIN)

% Choose default command line output for GUI_PatRecPlot
handles.outputPlot = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_PatRecPlot wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_PatRecPlot_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.outputPlot;
