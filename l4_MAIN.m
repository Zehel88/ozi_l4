%% ����������������� ����� 
function varargout = l4_MAIN(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @l4_MAIN_OpeningFcn, ...
                   'gui_OutputFcn',  @l4_MAIN_OutputFcn, ...
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

function l4_MAIN_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = l4_MAIN_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function edit1_Callback(hObject, eventdata, handles)

function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
set(hObject,'BackgroundColor','white');
end


function filebtn_Callback(hObject, eventdata, handles) 
%%������ ������ �����
if strcmp(get(handles.edit1,'Enable'),'on')==1
    % �������� ������ � �������� �����
    [FIN.name FIN.path F_ind]=uigetfile('*.*');
    % �������� �� ������ �� ����
    if F_ind==1
        %     ���� ������
        % �������� ��� ����������
        FIN.DaTa=fread(fopen(strcat(FIN.path,FIN.name)))';
        set(handles.filebtn,'String','������ ���������')
        set(handles.edit1,'String',['������ ����: ',FIN.name]);
        set(handles.edit1,'Enable','inactive')
        set(handles.edit1,'BackgroundColor',[.9 .9 .9])
    else
        %     ���� �� ������
    end
else
    set(handles.edit1,'BackgroundColor',[1 1 1]);
    set(handles.edit1,'Enable','on');
    set(handles.edit1,'String','�������� ����');
    set(handles.filebtn,'String','������� ����');
end