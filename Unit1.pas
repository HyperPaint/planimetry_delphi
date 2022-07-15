unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Spin, Menus;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N16: TMenuItem;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Image1: TImage;
    Graph: TImage;
    Memo1: TMemo;
    Memo2: TMemo;
    Label7: TLabel;
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure SpinEdit3Change(Sender: TObject);
    procedure FormClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  graph1,plosh,plosht,perim,perimt,ploshk,dlina:bool;
implementation

{$R *.dfm}

//Рамка чертежа? А вот и нет теперь это весь чертеж без фигуры
procedure bordergraph;
begin
  form1.Graph.Canvas.pen.color:=rgb(50,50,250);
  form1.Graph.Canvas.brush.color:=rgb(50,50,250);
  form1.Graph.Canvas.pen.width:=2;
  form1.Graph.Canvas.framerect(Rect(1,1,210,210));
  form1.Graph.Canvas.pen.color:=rgb(200,200,200);
  form1.Graph.canvas.Brush.color:=rgb(200,200,200);
  form1.graph.Canvas.rectangle(5,5,207,207);
  form1.Graph.Canvas.pen.color:=rgb(10,100,10);
  Form1.graph.Canvas.MoveTo(10,200);
  Form1.graph.Canvas.LineTo(200,200);
  Form1.graph.Canvas.MoveTo(10,200);
  Form1.graph.Canvas.LineTo(10,10);
end;

//Отрисовка прямоугольника
procedure buildrect;
var
a,b:real;
n:real;
begin
  bordergraph;
  n:=1.0;
  a:=form1.SpinEdit1.Value;
  b:=form1.SpinEdit2.Value;
  while ((a<=150.0) and (b<=150.0)) do
  begin
    a:=a*n;
    b:=b*n;
    n:=n+0.001;
  end;
  n:=1.0;
  while ((a>=170.0) or (b>=170.0)) do
  begin
    a:=a/n;
    b:=b/n;
    n:=n+0.001;
  end;
  form1.Graph.Canvas.pen.color:=rgb(100,10,10);
  Form1.graph.Canvas.MoveTo(15,195);
  Form1.graph.Canvas.LineTo(15+round(a),195);
  Form1.graph.Canvas.LineTo(15+round(a),195-round(b));
  Form1.graph.Canvas.LineTo(15,195-round(b));
  Form1.graph.Canvas.LineTo(15,195);
end;

//Отрисовка треугольника
procedure buildtri;
var
a,b,c,x,y:real;
n:real;
begin
  bordergraph;
  n:=1.0;
  a:=form1.SpinEdit1.Value;
  b:=form1.SpinEdit2.Value;
  c:=form1.SpinEdit3.Value;
  if ((a+b>c) and (a+c>b) and (b+c>a)) then
  begin
    while ((a<=150.0) and (b<=150.0)) do
    begin
      a:=a*n;
      b:=b*n;
      c:=c*n;
      n:=n+0.001;
    end;
    x:=(a*a+b*b-c*c)/(2.0*a);
    y:=sqrt(b*b-x*x);
    n:=1.0;
    while ((a>=170.0) or (b>=170.0)) do
    begin
      a:=a/n;
      b:=b/n;
      c:=c/n;
      n:=n+0.001;
    end;
    x:=(a*a+b*b-c*c)/(2*a);
    y:=sqrt(b*b-x*x);
    if a-x>190 then
    while ((a-x>=170.0) or (b-x>=170.0)) do
    begin
      a:=a/n;
      b:=b/n;
      c:=c/n;
      n:=n+0.001;
    end;
    form1.Graph.Canvas.pen.color:=rgb(100,10,10);
    if x>0.0 then
    begin
      Form1.graph.Canvas.MoveTo(15,195);
      Form1.graph.Canvas.LineTo(15+round(a),195);
      Form1.graph.Canvas.LineTo(15+round(x),195-round(y));
      Form1.graph.Canvas.LineTo(15,195);
    end
    else
    begin
      Form1.graph.Canvas.MoveTo(15-round(x),195);
      Form1.graph.Canvas.LineTo(15-round(x)+round(a),195);
      Form1.graph.Canvas.LineTo(15,195-round(y));
      Form1.graph.Canvas.LineTo(15-round(x),195);
    end;
  end
  else
  begin
    form1.label7.visible:=true;
  end;
end;

//Стартовое изображение
procedure screen;
begin
  form1.Label1.visible:=false;
  form1.Label2.visible:=false;
  form1.Label3.visible:=false;
  form1.Label4.visible:=false;
  form1.Label5.Visible:=false;
  form1.Label6.Visible:=false;
  form1.spinedit1.visible:=false;
  form1.spinedit2.visible:=false;
  form1.spinedit3.visible:=false;
  form1.graph.visible:=false;
  form1.Memo1.visible:=false;
  form1.Memo2.visible:=false;
  form1.Image1.visible:=true;
end;

procedure prepare(a,b:byte);
begin
  if a=1 then
  begin
    form1.label1.caption:='Сторона А';
    form1.label2.caption:='Сторона В';
    //form1.label3.caption:='Сторона С';
    form1.Label4.caption:='Прямоугольник';
    form1.Label1.visible:=true;
    form1.Label2.visible:=true;
    form1.Label3.visible:=false;
    form1.Label4.visible:=true;
    form1.spinedit1.visible:=true;
    form1.spinedit2.visible:=true;
    form1.spinedit3.visible:=false;
    form1.graph.visible:=true;
    form1.Image1.visible:=false;
    form1.Memo1.visible:=false;
    form1.Memo2.visible:=false;
    //Площадь
    if b=1 then
    begin
      form1.Label5.caption:='Площадь:';
      form1.Label6.caption:='0';
      form1.Label5.visible:=true;
      form1.Label6.visible:=true;
    end;
    //Периметр
    if b=2 then
    begin
      form1.Label5.caption:='Периметр:';
      form1.Label6.caption:='0';
      form1.Label5.visible:=true;
      form1.Label6.visible:=true;
    end;
    //Чертёж
    if b=3 then
    begin
      form1.Label5.visible:=false;
      form1.Label6.visible:=false;
    end;
  end;
  if a=2 then
  begin
    form1.label1.caption:='Сторона А';
    form1.label2.caption:='Сторона В';
    form1.label3.caption:='Сторона С';
    form1.Label4.caption:='Треугольник';
    form1.Label1.visible:=true;
    form1.Label2.visible:=true;
    form1.Label3.visible:=true;
    form1.Label4.visible:=true;
    form1.spinedit1.visible:=true;
    form1.spinedit2.visible:=true;
    form1.spinedit3.visible:=true;
    form1.graph.visible:=true;
    form1.Image1.visible:=false;
    form1.Memo1.visible:=false;
    form1.Memo2.visible:=false;
    //Площадь
    if b=1 then
    begin
      form1.Label5.caption:='Площадь:';
      form1.Label6.caption:='0';
      form1.Label5.visible:=true;
      form1.Label6.visible:=true;
    end;
    //Периметр
    if b=2 then
    begin
      form1.Label5.caption:='Периметр:';
      form1.Label6.caption:='0';
      form1.Label5.visible:=true;
      form1.Label6.visible:=true;
    end;
    //Чертеж
    if b=3 then
    begin
      form1.Label5.visible:=false;
      form1.Label6.visible:=false;
    end;
  end;
  if a=3 then
  begin
    form1.label1.caption:='Радиус';
    //form1.label2.caption:='Сторона В';
    //form1.label3.caption:='Сторона С';
    form1.Label4.caption:='Круг';
    form1.Label1.visible:=true;
    form1.Label2.visible:=false;
    form1.Label3.visible:=false;
    form1.Label4.visible:=true;
    form1.spinedit1.visible:=true;
    form1.spinedit2.visible:=false;
    form1.spinedit3.visible:=false;
    form1.graph.visible:=true;
    form1.Image1.visible:=false;
    form1.Memo1.visible:=false;
    form1.Memo2.visible:=false;
    if b=1 then
    //Площадь
    begin
      form1.Label5.caption:='Площадь:';
      form1.Label6.caption:='0';
      form1.Label5.visible:=true;
      form1.Label6.visible:=true;
    end;
    if b=2 then
    begin
      form1.Label5.caption:='Длина окружности:';
      form1.Label6.caption:='0';
      form1.Label5.visible:=true;
      form1.Label6.visible:=true;
    end;
  end;
end;

//Установка значения 1 в SpinEdit1-3
procedure sesn;
begin
  form1.SpinEdit1.value:=1;
  form1.SpinEdit2.value:=1;
  form1.SpinEdit3.value:=1;
end;

//Прямоугольник - Площадь
procedure TForm1.N6Click(Sender: TObject);
begin
  sesn;
  prepare(1,1);
  bordergraph;
  graph1:=false;
  plosh:=true;
  perim:=false;
  dlina:=false;
  plosht:=false;
  ploshk:=false;
  perimt:=false;
  form1.label6.caption:=inttostr(form1.SpinEdit1.value*form1.SpinEdit2.value);
end;

//Прямоугольник - Периметр
procedure TForm1.N7Click(Sender: TObject);
begin
  sesn;
  prepare(1,2);
  bordergraph;
  graph1:=false;
  plosh:=false;
  perim:=true;
  dlina:=false;
  plosht:=false;
  ploshk:=false;
  perimt:=false;
  form1.label6.caption:=inttostr((form1.SpinEdit1.value+form1.SpinEdit2.value)*2);
end;

//Прямоугольник - Чертеж
procedure TForm1.N8Click(Sender: TObject);
begin
  sesn;
  prepare(1,3);
  bordergraph;
  graph1:=true;
  plosh:=false;
  perim:=false;
  dlina:=false;
  plosht:=false;
  ploshk:=false;
  perimt:=false;
  if form1.SpinEdit3.visible then buildtri else buildrect;
end;

//Прямоугольник - Выход
procedure TForm1.N9Click(Sender: TObject);
begin
  sesn;
  screen;
end;

//Треугольник - Площадь
procedure TForm1.N10Click(Sender: TObject);
begin
  sesn;
  prepare(2,1);
  bordergraph;
  graph1:=false;
  plosh:=false;
  perim:=false;
  dlina:=false;
  plosht:=true;
  ploshk:=false;
  perimt:=false;
  if ((form1.SpinEdit1.value+form1.SpinEdit2.value>form1.SpinEdit3.value) and (form1.SpinEdit1.value+form1.SpinEdit3.value>form1.SpinEdit2.value) and (form1.SpinEdit2.value+form1.SpinEdit3.value>form1.SpinEdit1.value)) then
  form1.label6.caption:=copy(floattostr(sqrt(((form1.SpinEdit1.value+form1.SpinEdit2.value+form1.SpinEdit3.value)/2)*(((form1.SpinEdit1.value+form1.SpinEdit2.value+form1.SpinEdit3.value)/2)-form1.SpinEdit1.value)*(((form1.SpinEdit1.value+form1.SpinEdit2.value+form1.SpinEdit3.value)/2)-form1.SpinEdit2.value)*(((form1.SpinEdit1.value+form1.SpinEdit2.value+form1.SpinEdit3.value)/2)-form1.SpinEdit3.value))),1,10)
  else
  begin
    form1.label7.visible:=true;
    form1.label6.Caption:='Ошибка';
  end;
end;

//Треугольник - Периметр
procedure TForm1.N11Click(Sender: TObject);
begin
  sesn;
  prepare(2,2);
  bordergraph;
  graph1:=false;
  plosh:=false;
  perim:=false;
  dlina:=false;
  plosht:=false;
  ploshk:=false;
  perimt:=true;
  if ((form1.SpinEdit1.value+form1.SpinEdit2.value>form1.SpinEdit3.value) and (form1.SpinEdit1.value+form1.SpinEdit3.value>form1.SpinEdit2.value) and (form1.SpinEdit2.value+form1.SpinEdit3.value>form1.SpinEdit1.value)) then
  form1.label6.caption:=inttostr(form1.SpinEdit1.value+form1.SpinEdit2.value+form1.SpinEdit3.value)
  else
  begin
    form1.label7.visible:=true;
    form1.label6.Caption:='Ошибка';
  end;
end;

//Треугольник - Чертеж
procedure TForm1.N12Click(Sender: TObject);
begin
  sesn;
  prepare(2,3);
  bordergraph;
  graph1:=true;
  plosh:=false;
  perim:=false;
  dlina:=false;
  plosht:=false;
  ploshk:=false;
  perimt:=false;
  if form1.SpinEdit3.visible then buildtri else buildrect;
end;

//Треугольник - Выход
procedure TForm1.N13Click(Sender: TObject);
begin
  sesn;
  screen;
end;

//Круг - Площадь
procedure TForm1.N14Click(Sender: TObject);
begin
  sesn;
  prepare(3,1);
  bordergraph;
  graph1:=false;
  plosh:=false;
  perim:=false;
  dlina:=false;
  plosht:=false;
  ploshk:=true;
  perimt:=false;
  form1.label6.caption:=copy(floattostr(pi*form1.SpinEdit1.value*form1.SpinEdit1.value),1,10);
end;

//Круг - Длина окружности
procedure TForm1.N15Click(Sender: TObject);
begin
  sesn;
  prepare(3,2);
  bordergraph;
  graph1:=false;
  plosh:=false;
  perim:=false;
  dlina:=true;
  plosht:=false;
  ploshk:=false;
  perimt:=false;
  form1.label6.caption:=copy(floattostr(2*pi*form1.SpinEdit1.value),1,10);
end;

//Круг - Выход
procedure TForm1.N16Click(Sender: TObject);
begin
  sesn;
  screen;
end;

//Помощь - Формулы
procedure TForm1.N17Click(Sender: TObject);
begin
  form1.Memo1.visible:=true;
  form1.Memo2.visible:=false;
  form1.Label1.visible:=false;
  form1.Label2.visible:=false;
  form1.Label3.visible:=false;
  form1.Label4.visible:=false;
  form1.Label5.Visible:=false;
  form1.Label6.Visible:=false;
  form1.spinedit1.visible:=false;
  form1.spinedit2.visible:=false;
  form1.spinedit3.visible:=false;
  form1.graph.visible:=false;
  form1.Image1.visible:=false;
end;

//Помощь - О программе
procedure TForm1.N18Click(Sender: TObject);
begin
  form1.Memo2.visible:=true;
  form1.Memo1.visible:=false;
  form1.Label1.visible:=false;
  form1.Label2.visible:=false;
  form1.Label3.visible:=false;
  form1.Label4.visible:=false;
  form1.Label5.Visible:=false;
  form1.Label6.Visible:=false;
  form1.spinedit1.visible:=false;
  form1.spinedit2.visible:=false;
  form1.spinedit3.visible:=false;
  form1.graph.visible:=false;
  form1.Image1.visible:=false;
end;

//Выход
procedure TForm1.N5Click(Sender: TObject);
begin
  close;
end;

//Сторона А
procedure TForm1.SpinEdit1Change(Sender: TObject);
begin
  form1.Label7.visible:=false;
  if graph1 then
  begin
    if form1.SpinEdit3.visible then buildtri else buildrect;
  end;
  if plosh then form1.label6.caption:=inttostr(form1.SpinEdit1.value*form1.SpinEdit2.value);
  if perim then form1.label6.caption:=inttostr((form1.SpinEdit1.value+form1.SpinEdit2.value)*2);
  if perimt then
  if ((form1.SpinEdit1.value+form1.SpinEdit2.value>form1.SpinEdit3.value) and (form1.SpinEdit1.value+form1.SpinEdit3.value>form1.SpinEdit2.value) and (form1.SpinEdit2.value+form1.SpinEdit3.value>form1.SpinEdit1.value)) then
  begin
    form1.label6.caption:=inttostr(form1.SpinEdit1.value+form1.SpinEdit2.value+form1.SpinEdit3.value);
  end
  else
  begin
    form1.label7.visible:=true;
    form1.label6.Caption:='Ошибка';
  end;
  if plosht then
  if ((form1.SpinEdit1.value+form1.SpinEdit2.value>form1.SpinEdit3.value) and (form1.SpinEdit1.value+form1.SpinEdit3.value>form1.SpinEdit2.value) and (form1.SpinEdit2.value+form1.SpinEdit3.value>form1.SpinEdit1.value)) then
  begin
    form1.label6.caption:=copy(floattostr(sqrt(((form1.SpinEdit1.value+form1.SpinEdit2.value+form1.SpinEdit3.value)/2)*(((form1.SpinEdit1.value+form1.SpinEdit2.value+form1.SpinEdit3.value)/2)-form1.SpinEdit1.value)*(((form1.SpinEdit1.value+form1.SpinEdit2.value+form1.SpinEdit3.value)/2)-form1.SpinEdit2.value)*(((form1.SpinEdit1.value+form1.SpinEdit2.value+form1.SpinEdit3.value)/2)-form1.SpinEdit3.value))),1,10);
  end
  else
  begin
    form1.label7.visible:=true;
    form1.label6.Caption:='Ошибка';
  end;
  if ploshk then form1.label6.caption:=copy(floattostr(pi*form1.SpinEdit1.value*form1.SpinEdit1.value),1,10);
  if dlina then form1.label6.caption:=copy(floattostr(2*pi*form1.SpinEdit1.value),1,10);
end;

//Сторона В
procedure TForm1.SpinEdit2Change(Sender: TObject);
begin
  form1.Label7.visible:=false;
  if graph1 then
  begin
    if form1.SpinEdit3.visible then buildtri else buildrect;
  end;
  if plosh then form1.label6.caption:=inttostr(form1.SpinEdit1.value*form1.SpinEdit2.value);
  if perim then form1.label6.caption:=inttostr((form1.SpinEdit1.value+form1.SpinEdit2.value)*2);
  if perimt then
  if ((form1.SpinEdit1.value+form1.SpinEdit2.value>form1.SpinEdit3.value) and (form1.SpinEdit1.value+form1.SpinEdit3.value>form1.SpinEdit2.value) and (form1.SpinEdit2.value+form1.SpinEdit3.value>form1.SpinEdit1.value)) then
  begin
    form1.label6.caption:=inttostr(form1.SpinEdit1.value+form1.SpinEdit2.value+form1.SpinEdit3.value);
  end
  else
  begin
    form1.label7.visible:=true;
    form1.label6.Caption:='Ошибка';
  end;
  if plosht then
  if ((form1.SpinEdit1.value+form1.SpinEdit2.value>form1.SpinEdit3.value) and (form1.SpinEdit1.value+form1.SpinEdit3.value>form1.SpinEdit2.value) and (form1.SpinEdit2.value+form1.SpinEdit3.value>form1.SpinEdit1.value)) then
  begin
    form1.label6.caption:=copy(floattostr(sqrt(((form1.SpinEdit1.value+form1.SpinEdit2.value+form1.SpinEdit3.value)/2)*(((form1.SpinEdit1.value+form1.SpinEdit2.value+form1.SpinEdit3.value)/2)-form1.SpinEdit1.value)*(((form1.SpinEdit1.value+form1.SpinEdit2.value+form1.SpinEdit3.value)/2)-form1.SpinEdit2.value)*(((form1.SpinEdit1.value+form1.SpinEdit2.value+form1.SpinEdit3.value)/2)-form1.SpinEdit3.value))),1,10);
  end
  else
  begin
    form1.label7.visible:=true;
    form1.label6.Caption:='Ошибка';
  end;
  if ploshk then form1.label6.caption:=copy(floattostr(pi*form1.SpinEdit1.value*form1.SpinEdit1.value),1,10);
  if dlina then form1.label6.caption:=copy(floattostr(2*pi*form1.SpinEdit1.value),1,10);
end;

//Сторона С
procedure TForm1.SpinEdit3Change(Sender: TObject);
begin
  form1.Label7.visible:=false;
  if graph1 then
  begin
    if form1.SpinEdit3.visible then buildtri else buildrect;
  end;
  if plosh then form1.label6.caption:=inttostr(form1.SpinEdit1.value*form1.SpinEdit2.value);
  if perim then form1.label6.caption:=inttostr((form1.SpinEdit1.value+form1.SpinEdit2.value)*2);
  if perimt then
  if ((form1.SpinEdit1.value+form1.SpinEdit2.value>form1.SpinEdit3.value) and (form1.SpinEdit1.value+form1.SpinEdit3.value>form1.SpinEdit2.value) and (form1.SpinEdit2.value+form1.SpinEdit3.value>form1.SpinEdit1.value)) then
  begin
    form1.label6.caption:=inttostr(form1.SpinEdit1.value+form1.SpinEdit2.value+form1.SpinEdit3.value);
  end
  else
  begin
    form1.label7.visible:=true;
    form1.label6.Caption:='Ошибка';
  end;
  if plosht then
  if ((form1.SpinEdit1.value+form1.SpinEdit2.value>form1.SpinEdit3.value) and (form1.SpinEdit1.value+form1.SpinEdit3.value>form1.SpinEdit2.value) and (form1.SpinEdit2.value+form1.SpinEdit3.value>form1.SpinEdit1.value)) then
  begin
    form1.label6.caption:=copy(floattostr(sqrt(((form1.SpinEdit1.value+form1.SpinEdit2.value+form1.SpinEdit3.value)/2)*(((form1.SpinEdit1.value+form1.SpinEdit2.value+form1.SpinEdit3.value)/2)-form1.SpinEdit1.value)*(((form1.SpinEdit1.value+form1.SpinEdit2.value+form1.SpinEdit3.value)/2)-form1.SpinEdit2.value)*(((form1.SpinEdit1.value+form1.SpinEdit2.value+form1.SpinEdit3.value)/2)-form1.SpinEdit3.value))),1,10);
  end
  else
  begin
    form1.label7.visible:=true;
    form1.label6.Caption:='Ошибка';
  end;
  if ploshk then form1.label6.caption:=copy(floattostr(pi*form1.SpinEdit1.value*form1.SpinEdit1.value),1,10);
  if dlina then form1.label6.caption:=copy(floattostr(2*pi*form1.SpinEdit1.value),1,10);
end;

//Убирание ошибки
procedure TForm1.FormClick(Sender: TObject);
begin
  form1.Label7.visible:=false;
end;
end.
