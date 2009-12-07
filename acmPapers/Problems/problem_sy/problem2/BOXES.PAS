Program Boxes(input,output);  {�ڶ��⣺��������}
const   inputfile               =       'boxes.in';
        outputfile              =       'boxes.out';
        MAXN                    =       1000;
        MAXW                    =       3000;
type    newtype                 =       array [0..MAXW] of shortint;
var     w0,w1                   :       array [1..MAXN] of integer;
        f0,f1                   :       array [0..MAXW] of integer;
        p                       :       array [1..MAXN] of ^ newtype;
        n,max                   :       integer;
procedure initialize;		{��������}
var       i         :           integer;
begin
  assign(input,inputfile);
  reset(input);
  read(n);
  max:=0;
  for i:=1 to n do
    begin
      read(w0[i],w1[i]);	{����ÿ�����ӵı���������ɳ�������}
      if w1[i]>max then max:=w1[i];
    end;
  close(input);
end;
function value(k:integer):integer;  {���������������max����ôf����ֵ��Ϊ0}
begin
  if k>max then value:=0
    else value:=f0[k];
end;
procedure solve;		{������}
var     i,j,s,k,k0,k1   :       integer;
begin
  assign(output,outputfile);
  rewrite(output);
  fillchar(f0,sizeof(f0),0);	{����������ɵ������ӵĸ���}
  for i:=1 to n do
    begin
      for j:=0 to max do
        begin
          if (value(j+w0[i])+1>f0[j])and(j<=w1[i]) then f1[j]:=value(j+w0[i])+1
              else f1[j]:=f0[j];
        end;
      f0:=f1;
    end;
  k0:=n;k1:=0;
  for i:=0 to max do
    if f0[i]>f0[k1] then k1:=i;	   {ȷ����̬�滮��Ŀ��f[k0,k1]}
  writeln(f0[k1]);		   {��ӡ���ɵ������ӵ���Ŀ}	
  repeat
    s:=1;
    fillchar(f0,sizeof(f0),0);
    for i:=1 to k0 do
      begin
        if memavail<MAXW+1 then	   {����ڴ治�������ͷ�p[s]}
          begin
            dispose(p[s]);
            s:=s+1;
          end;
        new(p[i]);		  {�����ڴ�}
        fillchar(p[i]^,sizeof(p[i]^),0);
        for j:=0 to max do
          begin
            if (value(j+w0[i])+1>f0[j])and(j<=w1[i]) then
              begin
                f1[j]:=value(j+w0[i])+1;	{ȡ��i������}
                p[i]^[j]:=1;
              end
              else
                begin
                  f1[j]:=f0[j];			{��ȡ��i������}
                  p[i]^[j]:=0;
                end;
          end;
        f0:=f1;
      end;
    k:=k0;		{�����󷽰�}
    while k0>=s do
      begin
        while (k0>=s)and(p[k0]^[k1]=0) do k0:=k0-1;
        if k0<s then break;
        writeln(k0);
        k1:=k1+w0[k0];
        k0:=k0-1;
      end;
    for i:=s to k do dispose(p[i]);	{�ͷ���ռ�е��ڴ�}
  until k0=0;
  close(output);
end;
begin
  initialize;
  solve;
end.