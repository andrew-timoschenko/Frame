// Scilab ( http://www.scilab.org/ ) - This file is created for Scilab 5
// Copyright (C) 2011 - Andrew Timoschenko <andrew.timoschenko@yandex.ru>
// This file must be used under the terms of the (CC)BY-SA licence.

// Version 1.01 from 23/08/2012

// не проверен

// Определение усилий и моментов в раме по схеме 133 [Бычков Д.В. Формулы и графики для расчета рам. -М.: Госстройиздат, 1957]
// для стоек и распорки прямоугольного сечения.

clear;clc; m=1.0; Pa=1; N=1; mm=0.001; kN=1000; MN=1e6; kPa=1000; MPa=1e6; GPa=1e9; mm2=mm^2; kNm=1000; // Подготовка консоли и размерности

// Стойка рамы
b1=0.800*m; h1=1.200*m; l1=2.400*m; J1=0;      // если стойка прямоугольная принять J1=0; иначе - ввести численное значение момента инерции площади поперечного сечения	

// Ригель рамы 
b2=0.800*m; h2=1.200*m; l2=4.000*m; J2=0;      // если ригель прямоугольный принять J1=0; иначе - ввести численное значение момента инерции площади поперечного сечения	

// Нагрузка
P=1545.0*kN; u=0.31;

//                l                      схема 133, с.102
//
//      /--u*l--/------v*l----/
//
//            P |
//              v
//    c --------+-------------- d     
//      |                     |      
//      |                     |      h
//      |                     |      
//    a |                  b  |      
//   -------               -------   
//   / / / /               / / / /
//

// ==================== Calculation begin ====================================
v=1-u

// 
if J1==0 then J1=b1*h1**3/12
end

if J2==0 then J2=b2*h2**3/12
end

// 
h=l1; l=l2;
mu=J2/J1*h/l;
K=1/(2+mu);
L=1/(1+6*mu);

mu=round(mu*1000)/1000; K=round(K*1000)/1000; L=round(L*1000)/1000;

// 
M_c=[0.5*(v-u)*L+K]*P*u*v*l;
M_d=[K-0.5*(v-u)*L]*P*u*v*l;
M_a=[K-(v-u)*L]*P*u*v*l/2;
M_b=[K+(v-u)*L]*P*u*v*l/2;
M_p=[1-K-0.5*(v-u)**2*L]*P*u*v*l;

M_c=round(M_c/100)*100; M_d=round(M_d/100)*100; M_a=round(M_a/100)*100; M_b=round(M_b/100)*100; M_p=round(M_p/100)*100; 
// 
H=1.5*K*P*u*v*l/h;
V_a=[1+u*(v-u)*L]*P*v;
V_b=[1-u*(v-u)*L]*P*u;

H=round(H/100)*100; V_a=round(V_a/100)*100; V_b=round(V_b/100)*100; 
// ========================= Report ===================================



printf('\nJ1='+string(J1)+' м4.\n');
printf('J2='+string(J2)+' м4.\n\n');

printf('#mu='+string(mu)+'; ');
printf('K='+string(K)+'; ');
printf('L='+string(L)+'.\n\n');

printf('M_c='+string(M_c/kNm)+' кНм.\n');
printf('M_d='+string(M_d/kNm)+' кНм.\n\n');
printf('M_a='+string(M_a/kNm)+' кНм.\n');
printf('M_b='+string(M_b/kNm)+' кНм.\n\n');
printf('M_p='+string(M_p/kNm)+' кНм.\n\n');

printf('H='+string(H/kN)+' кН.\n');
printf('V_a='+string(V_a/kN)+' кН.\n');
printf('V_b='+string(V_b/kN)+' кН.\n');

// Changelog

// 1.00   25.04.2012

// 1.01   23.08.2012 
// Добавлена возможность расчета для стержней произвольного сечения через использование численных характеристик J.
// Если J1,2=0 момент инерции площади сечения вычисляется как для прямоугольного сечения
