// Scilab ( http://www.scilab.org/ ) - This file is created for Scilab 5
// Copyright (C) 2011 - Andrew Timoschenko <andrew.timoschenko@yandex.ru>
// This file must be used under the terms of the (CC)BY-SA licence.

// Version 1.00 from 04/09/2012

// не проверен

// Определение усилий и моментов в раме по схеме 124 [Бычков Д.В. Формулы и графики для расчета рам. -М.: Госстройиздат, 1957]
// для стоек и распорки прямоугольного сечения.

clear;clc; m=1.0; Pa=1; N=1; mm=0.001; kN=1000; MN=1e6; kPa=1000; MPa=1e6; GPa=1e9; mm2=mm^2; kNm=1000; // Подготовка консоли и размерности

// Стойка рамы
b1=0.800*m; h1=1.200*m; l1=2.400*m; J1=0;      // если стойка прямоугольная принять J1=0; иначе - ввести численное значение момента инерции площади поперечного сечения	

// Ригель рамы 
b2=0.800*m; h2=1.200*m; l2=4.000*m; J2=0;      // если ригель прямоугольный принять J1=0; иначе - ввести численное значение момента инерции площади поперечного сечения	

// Модуль упругости
E=30*GPa;

// единичный поворот стойки ас относительно основания


//                                      схема 124, с.99
//                 l2
//      /---------------------/
//            
//    c ======================= d   ----  
//      ||                    ||       ^
//      || 1                  ||       |
//      ||  /                 ||       | l1
//      || /                  ||       |
//    a ||                  b ||       v
//   -------               -------   ---
//   / / / /               / / / /
//

// ==================== Calculation begin ====================================

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
M_c=mu*(K-3*L)*E*J1/h;
M_d=mu*(K+3*L)*E*J1/h;
M_a=[ (3+2*mu)*K+3*mu*L ]*E*J1/h;
M_b=[ (3+2*mu)*K-3*mu*L ]*E*J1/h;

M_c=round(M_c/100)*100; M_d=round(M_d/100)*100; M_a=round(M_a/100)*100; M_b=round(M_b/100)*100; 
// 
H=(1+mu)*K*(3*E*J1/h^2);
V=mu*L*(6*E*J1/[h*l]);


H=round(H/100)*100; V=round(V/100)*100;
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

printf('H='+string(H/kN)+' кН.\n');
printf('V='+string(V/kN)+' кН.\n');


// Changelog

// 1.00   04.09.2012
