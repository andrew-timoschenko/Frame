// Scilab ( http://www.scilab.org/ ) - This file is created for Scilab 5
// Copyright (C) 2011 - Andrew Timoschenko <andrew.timoschenko@yandex.ru>
// This file must be used under the terms of the (CC)BY-SA licence.

// Version 1.00 from 23/08/2012

// не проверен

// Определение усилий и моментов в раме по схеме 130 [Бычков Д.В. Формулы и графики для расчета рам. -М.: Госстройиздат, 1957]
// для стоек и распорки прямоугольного сечения.

clear; m=1.0; Pa=1; N=1; mm=0.001; kN=1000; MN=1e6; kPa=1000; MPa=1e6; GPa=1e9; mm2=mm^2; kNm=1000; // Подготовка консоли и размерности

// Стойка рамы
b1=0.800*m; h1=1.200*m; l1=2.400*m; J1=0;      // если стойка прямоугольная принять J1=0; иначе - ввести численное значение момента инерции площади поперечного сечения	

// Ригель рамы 
b2=0.800*m; h2=1.200*m; l2=4.000*m; J2=0;      // если ригель прямоугольный принять J1=0; иначе - ввести численное значение момента инерции площади поперечного сечения	

// Сила
P=45.0*kN; 

//                                       схема 130, с.101
//                      l2
//          |<------------------->|
//          |                     |   
//                 
//  p                               
// --->    c --------------------- d     ----  
//          |                     |        ^
//          |                     |        |
//          |                     |        | l1
//          |                     |        | 
//        a |                  b  |        v
//       -------               -------   --- 
//       / / / /               / / / /
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
M_c=3*mu*L*(P*h/2);
M_d=M_c;
M_a=(1-3*mu*L)*(P*h/2);
M_b=M_a;
M_p=0;

M_c=round(M_c/100)*100; M_d=round(M_d/100)*100; M_a=round(M_a/100)*100; M_b=round(M_b/100)*100; M_p=round(M_p/100)*100; 
// 
H_a=P/2;
H_b=H_a
V_a=3*mu*L*(P*h/l);
V_b=V_a;

H_a=round(H_a/100)*100; H_b=round(H_b/100)*100; V_a=round(V_a/100)*100; V_b=round(V_b/100)*100; 
// ========================= Report ===================================



printf('\nJ1='+string(J1)+' м4.\n');
printf('J2='+string(J2)+' м4.\n\n');

printf('#mu='+string(mu)+'; ');
printf('K='+string(K)+'; ');
printf('L='+string(L)+'.\n\n');

printf('M_c=M_d='+string(M_c/kNm)+' кНм.\n');
printf('M_a=M_b='+string(M_a/kNm)+' кНм.\n\n');

printf('H_a=-H_b='+string(H_a/kN)+' кН.\n');
printf('V_a=V_b='+string(V_a/kN)+' кН.\n');


// Changelog

// 1.00   23.08.2012
