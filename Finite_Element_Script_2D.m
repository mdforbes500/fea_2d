% 2D Finite Element Main Script

%NOTE: This script uses the distmesh package (under the GNU licesnse) created
%by Pers Olaf-Persson, MIT. Per the GNU license, this script is also
%GNU. In addition, the distmesh package is functionally organized, not
%class organized, and its subfolder must be added to the user's path to
%run.

clc
clear
close all

%Step 1:
%Define domain

%omega is a circle with a hole in it
omega = @(p) ddiff(drectangle(p,-1,1,-1,1),dcircle(p,0,0,0.5));

%Step 2:
%Discretize Domain

%Mesh Refinement Function:
%creates a larger element size away from the edge of the circlular cutout,
%and a smaller element size around the hole
mesh_refine = @(p) 0.05+0.3*dcircle(p,0,0,0.5);

%Creation and display of initial mesh before manipulation:
[p,t] = distmesh2d(omega,mesh_refine, 0.05, [-1,-1;1,1],[-1,-1;-1,1;1,-1;1,1]);
lambda = boundedges(p,t);

%Define element properties 
a = [1 1;1 1];
f = 1;
elements = avengers(a, f, p, t, lambda);

%Step 3, 4, and 5: create local stiffness matrices, force vectors, and 
%boundary conditions; assemble global siffness matrices, force vectors, and
%boundary conditions
[K_e, F_e] = assembler(elements);

%Step 6:
%Solve matrix equation

%Setp 7:
%Post-processing of results

%Ploting 2D graph