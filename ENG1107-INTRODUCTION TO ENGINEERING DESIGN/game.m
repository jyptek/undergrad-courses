function game
    fig=figure('numbertitle','off','menubar','none','toolbar','none','name','∞‘¿”-5¡∂','color','black','position',[0 0 500 700],'userdata',0);
    global score
    global health
    global live
    global mp
    global bcnt
    mp=0;
    live=1;
    health=100;
    score=0;
    bcnt=1;
    movegui('center');
    sc=imread('sc.jpg');
    as=imread('asteroid.jpg');
    die=imread('gameover.jpg');
    back=imread('back.jpg');
    boomimg=imread('boom.jpg');
    background=uicontrol('style','pushbutton','cdata',back,'position',[0 0 500 1400],'visible','on');
    handles.main=uicontrol('style','pushbutton','position',[0 0 40 39],'cdata',sc,'userdata',0,'visible','on');
    handles.bullet(1)=uicontrol('style','pushbutton','position',[0 0 5 30],'visible','off','backgroundcolor','red','userdata',0);
    handles.bullet(2)=uicontrol('style','pushbutton','position',[0 0 5 30],'visible','off','backgroundcolor','red','userdata',0);
    handles.bullet(3)=uicontrol('style','pushbutton','position',[0 0 5 30],'visible','off','backgroundcolor','red','userdata',0);
    handles.enemy(1)=uicontrol('style','pushbutton','position',[0 0 40 39],'visible','off','cdata',as,'userdata',[0 0]);
    handles.enemy(2)=uicontrol('style','pushbutton','position',[0 0 40 39],'visible','off','cdata',as);
    handles.enemy(3)=uicontrol('style','pushbutton','position',[0 0 40 39],'visible','off','cdata',as);
    handles.enemy(4)=uicontrol('style','pushbutton','position',[0 0 40 39],'visible','off','cdata',as);
    handles.enemy(5)=uicontrol('style','pushbutton','position',[0 0 40 39],'visible','off','cdata',as);
    handles.bomb=uicontrol('style','pushbutton','position',[0 0 500 700],'visible','off','cdata',boomimg);
    handles.scoreb=uicontrol('style','text','position',[0 640 100 50],'backgroundcolor','w','string','0','fontsize',30);
    handles.bombre=uicontrol('style','text','position',[0 590 100 50],'backgroundcolor','w','string','1','fontsize',30);
    handles.hpbar=uicontrol('style','pushbutton','position',[0 10 500 10],'backgroundcolor','r');
    handles.mpbar=uicontrol('style','pushbutton','position',[0 0 0 10],'backgroundcolor','b');
    handles.go=uicontrol('style','pushbutton','position',[10 300 480 480],'cdata',die,'visible','off');
    set(fig,'windowbuttonmotionfcn',{@main_character,handles});
    set(fig,'windowbuttondownfcn',{@click,handles});
     set(fig,'WindowKeyPressFcn',{@bomb,handles});
    while(live==1)
        frame_time=0;
        tic
        bullet(handles);
        enemy(handles);
        didhit(handles);
        hpcon(handles);
        land(background);
        frame_time=toc;
        while frame_time<0.0165
            frame_time=toc;
        end
    end
    set(handles.main,'visible','off');
    set(handles.scoreb,'position',[200 150 100 50]);
    set(handles.bombre,'visible','off');
    set(handles.mpbar,'visible','off');
    set(handles.hpbar,'visible','off');
    for i=1:1:3
        set(handles.bullet(i),'visible','off');
    end
    for i=1:1:5
        set(handles.enemy(i),'visible','off');
    end
    set(handles.go,'visible','on');
end
function click(fig, event_data, handles)
    global live
    if live==1
    position=get(handles.main,'position');
    for a=1:1:3
        if get(handles.bullet(a),'userdata')==0
            set(handles.bullet(a),'userdata',1,'position',[position(1)+17.5 position(2) 5 30],'visible','on');
            break;
        end
    end
    end
end
    
function main_character(fig, event_data, handles)
    mousepos=get(fig,'Currentpoint');
    position=get(handles.main,'position');
    position(1)=mousepos(1)-20;
    position(2)=mousepos(2)-19.5;
    set(handles.main,'position',position);
    drawnow
end

function bullet(handles)
    pos1=get(handles.bullet(1),'position');
    pos2=get(handles.bullet(2),'position');
    pos3=get(handles.bullet(3),'position');
    if(pos1(2)>700)
        set(handles.bullet(1),'userdata',0,'visible','off');
    end
    if(pos2(2)>700)
        set(handles.bullet(2),'userdata',0,'visible','off');
    end
    if(pos3(2)>700)
        set(handles.bullet(3),'userdata',0,'visible','off');
    end
    for i=1:1:3
        if(get(handles.bullet(i),'userdata')==1)
            posb=get(handles.bullet(i),'position');
            posb(2)=posb(2)+12;
            posb(3)=5;
            posb(4)=30;
            set(handles.bullet(i),'position',posb);
        end
    end    
    drawnow
end

function enemy(handles)
global health
k=get(handles.enemy(1),'userdata');
site1=get(handles.enemy(1),'position');
site2=get(handles.enemy(2),'position');
site3=get(handles.enemy(3),'position');
site4=get(handles.enemy(4),'position');
site5=get(handles.enemy(5),'position');
time=mod(k(1),180); 
patterns = 0;
if time==0 
patterns=round(4*rand(1));
k(2)=patterns;
set(handles.enemy(1),'visible','on');
set(handles.enemy(2),'visible','on');
set(handles.enemy(3),'visible','on');
set(handles.enemy(4),'visible','on');
set(handles.enemy(5),'visible','on');
if k(2)==0
    site1=[100 700 site1(3) site1(4)];
    site2=[170 700 site2(3) site2(4)];
    site3=[240 700 site3(3) site3(4)];
    site4=[310 700 site4(3) site4(4)];
    site5=[380 700 site5(3) site5(4)];
else if k(2)==1
    site1=[320 700 site1(3) site1(4)];
    site2=[280 750 site2(3) site2(4)];
    site3=[240 800 site3(3) site3(4)];
    site4=[200 850 site4(3) site4(4)];
    site5=[160 900 site5(3) site5(4)];
else if k(2)==2
    site1=[500 550 site1(3) site1(4)];
    site2=[560 550 site2(3) site2(4)];
    site3=[620 550 site3(3) site3(4)];
    site4=[680 550 site4(3) site4(4)];
    site5=[740 550 site5(3) site5(4)];
else if k(2)==3
    site1=[0 700 site1(3) site1(4)];
    site2=[40 750 site2(3) site2(4)];
    site3=[80 800 site3(3) site3(4)];
    site4=[120 850 site4(3) site4(4)];
    site5=[160 900 site5(3) site5(4)];
else if k(2)==4
    site1=[400 700 site1(3) site1(4)];
    site2=[360 750 site2(3) site2(4)];
    site3=[320 800 site3(3) site3(4)];
    site4=[280 850 site4(3) site4(4)];
    site5=[240 900 site5(3) site5(4)];
end
end
end
end
end
end
if k(2)==0||k(2)==1
    site1(2)=site1(2)-7;
    site2(2)=site2(2)-7;
    site3(2)=site3(2)-7;
    site4(2)=site4(2)-7;
    site5(2)=site5(2)-7;
else if k(2)==2
        site1(1)=site1(1)-5;
        site2(1)=site2(1)-5;
        site3(1)=site3(1)-5;
        site4(1)=site4(1)-5;
        site5(1)=site5(1)-5;
    else if k(2)==3
            site1(2)=site1(2)-7;
            site2(2)=site2(2)-7;
            site3(2)=site3(2)-7;
            site4(2)=site4(2)-7;
            site5(2)=site5(2)-7;
            site1(1)=site1(1)+3;
            site2(1)=site2(1)+3;
            site3(1)=site3(1)+3;
            site4(1)=site4(1)+3;
            site5(1)=site5(1)+3;
        else if k(2)==4
                site1(2)=site1(2)-7;
                site2(2)=site2(2)-7;
                site3(2)=site3(2)-7;
                site4(2)=site4(2)-7;
                site5(2)=site5(2)-7;
                site1(1)=site1(1)-3;
                site2(1)=site2(1)-3;
                site3(1)=site3(1)-3;
                site4(1)=site4(1)-3;
                site5(1)=site5(1)-3;
            end
        end
    end
end
        if site1(1)<0
            if strcmp(get(handles.enemy(1),'visible'),'on')==1
                health=health-10;
            end
            set(handles.enemy(1), 'visible', 'off')
        end
        if site2(1)<0
            if strcmp(get(handles.enemy(2),'visible'),'on')==1
                health=health-10;
            end
            set(handles.enemy(2), 'visible', 'off')
       
        end
        if site3(1)<0
            if strcmp(get(handles.enemy(3),'visible'),'on')==1
                health=health-10;
            end
            set(handles.enemy(3), 'visible', 'off')
            
        end
        if site4(1)<0
            if strcmp(get(handles.enemy(4),'visible'),'on')==1
                health=health-10;
            end
            set(handles.enemy(4), 'visible', 'off')
        end
        if site5(1)<0
            if strcmp(get(handles.enemy(5),'visible'),'on')==1
                health=health-10;
            end
            set(handles.enemy(5), 'visible', 'off')
        end
         if site1(2)<0
            if strcmp(get(handles.enemy(1),'visible'),'on')==1
                health=health-10;
            end
            set(handles.enemy(1), 'visible', 'off')
        end
        if site2(2)<0
            if strcmp(get(handles.enemy(2),'visible'),'on')==1
                health=health-10;
            end
            set(handles.enemy(2), 'visible', 'off')
        end
        if site3(2)<0
            if strcmp(get(handles.enemy(3),'visible'),'on')==1
                health=health-10;
            end
            set(handles.enemy(3), 'visible', 'off')
        end
        if site4(2)<0
            if strcmp(get(handles.enemy(4),'visible'),'on')==1
                health=health-10;
            end
            set(handles.enemy(4), 'visible', 'off')
        end
        if site5(2)<0
            if strcmp(get(handles.enemy(5),'visible'),'on')==1
                health=health-10;
            end
            set(handles.enemy(5), 'visible', 'off')
            end
    k(1)=k(1)+1;
    set(handles.enemy(1), 'userdata', k);
    set(handles.enemy(1), 'position', site1);
    set(handles.enemy(2), 'position', site2);
    set(handles.enemy(3), 'position', site3);
    set(handles.enemy(4), 'position', site4);
    set(handles.enemy(5), 'position', site5);
end

function didhit(handles)
    global health
    global mp
    global bcnt
    if get(handles.bullet(1),'userdata')==1
        bull1=get(handles.bullet(1),'position');
    end
    if get(handles.bullet(2),'userdata')==1
        bull2=get(handles.bullet(2),'position');
    end
    if get(handles.bullet(3),'userdata')==1
        bull3=get(handles.bullet(3),'position');
    end
    if get(handles.bullet(1),'userdata')==0
        bull1(1)=1000;
        bull1(2)=1000;
    end
    if get(handles.bullet(2),'userdata')==0
        bull2(1)=1000;
        bull2(2)=1000;
    end
    if get(handles.bullet(3),'userdata')==0
        bull3(1)=1000;
        bull3(2)=1000;
    end
    bull1(2)=bull1(2)+30;
    bull2(2)=bull2(2)+30;
    bull3(2)=bull3(2)+30;
    global score
    site1=get(handles.enemy(1),'position');
    site2=get(handles.enemy(2),'position');
    site3=get(handles.enemy(3),'position'); 
    site4=get(handles.enemy(4),'position');
    site5=get(handles.enemy(5),'position');
    bull=zeros(3,2);
    site=zeros(5,2);
    bull(1,1)=bull1(1);bull(1,2)=bull1(2);bull(2,1)=bull2(1);bull(2,2)=bull2(2);bull(3,1)=bull3(1);bull(3,2)=bull3(2);
    site(1,:)=site1(1:2);
    site(2,:)=site2(1:2);
    site(3,:)=site3(1:2);
    site(4,:)=site4(1:2);
    site(5,:)=site5(1:2);
    mainpos=get(handles.main,'position');
    pos=zeros(4,2);
    pos(1,:)=[mainpos(1)+10 mainpos(2)+10];
    pos(2,:)=[mainpos(1)+30 mainpos(2)+10];
    pos(3,:)=[mainpos(1)+10 mainpos(2)+29];
    pos(4,:)=[mainpos(1)+30 mainpos(2)+29];
    for a=1:1:3
        for b=1:1:5
            if(site(b,1)<=bull(a,1) && bull(a,1)<=(site(b,1)+40) && site(b,2)<=bull(a,2) && bull(a,2)<=(site(b,2)+39))
                if strcmp(get(handles.enemy(b),'visible'),'on')==1
                    score=score+10;
                    mp=mp+50;
                    if(mp>=500)
                        bcnt=bcnt+1;
                        set(handles.bombre,'string',num2str(bcnt));
                        mp=0;
                    end
                    set(handles.mpbar,'position',[0 0 mp 10]);
                    set(handles.scoreb,'string',num2str(score));
                    set(handles.enemy(b),'visible','off');
                end
            end
        end
    end
    for a=1:1:4
        for b=1:1:5
            if(site(b,1)<=pos(a,1) && pos(a,1)<=(site(b,1)+40) && site(b,2)<=pos(a,2) && pos(a,2)<=(site(b,2)+39))
                if strcmp(get(handles.enemy(b),'visible'),'on')==1
                    health=health-30;
                    if health==0
                    set(handles.hpbar,'position',[0 10 health*5 10]);
                    gameover();
                    end   
                    set(handles.enemy(b),'visible','off');
                end
            end
        end
    end       
end
function bomb(fig,event_data,handles)
global bcnt
global score
mode=get(fig,'CurrentCharacter');
if mode=='a'
    if bcnt>0
        tmp=0;
        bcnt=bcnt-1;
        for i=1:1:5
            tmp=tmp+strcmp(get(handles.enemy(i),'visible'),'on');
        end
        set(handles.enemy(1),'visible','off');
        set(handles.enemy(2),'visible','off');
        set(handles.enemy(3),'visible','off');
        set(handles.enemy(4),'visible','off');
        set(handles.enemy(5),'visible','off');
        set(handles.bomb,'visible','on');
        score=score+(tmp*10);
        set(handles.scoreb,'string',num2str(score));
        set(handles.bombre,'string',num2str(bcnt));
        pause(0.5);
        set(handles.bomb,'visible','off');
    end
end
end
function hpcon(handles)
    global health
    set(handles.hpbar,'position',[0 10 abs(health*5) 10]);
    if health<=0
        set(handles.hpbar,'position',[0 10 0 10]);
        gameover();
    end
end
function land(background)
pos=get(background,'position');
pos(2)=pos(2)-7;
if pos(2)<=-700
    pos(2)=0;
end
set(background,'position',pos);
drawnow
end
function gameover()
    global live
    live=0;
end