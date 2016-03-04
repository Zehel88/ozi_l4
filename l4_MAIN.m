%% Инициализационаая часть 
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
set(handles.l_Key,'Value',5)



function varargout = l4_MAIN_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function edit1_Callback(hObject, eventdata, handles)

function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
set(hObject,'BackgroundColor','white');
end


function filebtn_Callback(hObject, eventdata, handles) 
%%Кнопка выбора файла
if strcmp(get(handles.edit1,'Enable'),'on')==1
    % Получаем данные о желаемом файле
    [FIN.name FIN.path F_ind]=uigetfile('*.*');
    % Проверка на выбран ли файл
    if F_ind==1
        %     Если выбран
        % Получаем его содержимое
        FIN.DaTa=fread(fopen(strcat(FIN.path,FIN.name)))';
        set(handles.filebtn,'String','Ввести сообщение')
        set(handles.edit1,'String',['Выбран файл: ',FIN.name]);
        set(handles.edit1,'Enable','inactive')
        set(handles.edit1,'BackgroundColor',[.9 .9 .9])
        save('FIN.mat','FIN');
    else
        %     Если не выбран
    end
else
    set(handles.edit1,'BackgroundColor',[1 1 1]);
    set(handles.edit1,'Enable','on');
    set(handles.edit1,'String','Зашифруй меня');
    set(handles.filebtn,'String','Выбрать файл');
end

function l_Block_Callback(hObject, eventdata, handles)

function l_Block_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function l_Key_Callback(hObject, eventdata, handles)
switch get(handles.l_Key,'Value')
    case 1
        set(handles.edit2,'String',dec2bin((randi(255))))
    case 2
        set(handles.edit2,'String',dec2bin((randi(1023))))
    case 3
        set(handles.edit2,'String',dec2bin((randi(4095))))
    case 4
        set(handles.edit2,'String',dec2bin((randi(16383))))
    case 5
        set(handles.edit2,'String',dec2bin((randi(65535))))
end



function l_Key_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit2_Callback(hObject, eventdata, handles)

function edit2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)

function edit3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pushbutton2_Callback(hObject, eventdata, handles)
%% Зашифровать
clc
% Получаем сообщение
if strcmp(get(handles.edit1,'Enable'),'on')==1
    FIN.DaTa=double(get(handles.edit1,'String'))
else
load('FIN.mat');
end
% Получаем длину блока данных
B_S=get(handles.l_Block,'String');
l_B=str2double(B_S{get(handles.l_Block,'Value')});
n=16;
% Приводим сообщение к двоичному/однострочному виду
Mes=reshape(dec2bin(FIN.DaTa,n)',1,numel(dec2bin(FIN.DaTa,n)));
% Делим сообщение на блоки необходимого размера
if mod(numel(Mes),l_B)==0
    Mes=reshape(Mes,l_B,numel(Mes)/l_B)';
else
    Mes=strcat(Mes,dec2bin(0,l_B-mod(numel(Mes),l_B)));
    Mes=reshape(Mes,l_B,numel(Mes)/l_B)';
end
% Получаем кол-во раундов
R=str2double(get(handles.edit5,'String'));
% Получаем ключ
K=(get(handles.edit2,'String'));
% Выбираем ключ
K=K(end-(l_B/2)+1:end);
[r_Mes c_Mes]=size(Mes);
% Шифруем сообщение
for i=1:r_Mes
%     Для каждой строки (каждого блока)
    Mes_S(i,:)=Mes(i,:);
%     Выполняем R раундов(шагов)
    for j=1:R
%         Правая часть блока
        Mes_1h=Mes_S(i,1:l_B/2);
%         Левая часть блока
        Mes_2h=Mes_S(i,l_B/2+1:end);
        
        for m=1:l_B/2
            buf_Mes(m)=num2str(double(~strcmp(Mes_1h(m),K(m))));  
        end 
        Mes_S(i,:)=[Mes_2h buf_Mes];
    end
end
% Mes_S

Mes_S=reshape(Mes_S',1,numel(Mes_S));
% char(bin2dec(Mes_S(1:16)))
% return
% n=n/2;
for i=1:numel(Mes_S)/n
    M(i,:)=Mes_S(n*i-n+1:n*i);
end

M


Res=char(bin2dec(M))'


set(handles.edit3,'String',(Res))
% Устанавливаем стандарт кодирования символов




function edit4_Callback(hObject, eventdata, handles)

function edit4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pushbutton3_Callback(hObject, eventdata, handles)
%% Расшифровать
sM=get(handles.edit3,'String');
double(sM)


function edit5_Callback(hObject, eventdata, handles)
function edit5_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
