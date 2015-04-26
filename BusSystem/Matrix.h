//
//  Matrix.h
//  BusSystem
//
//  Created by 董思言 on 15/4/3.
//  Copyright (c) 2015年 董思言. All rights reserved.
//

#ifndef __BusSystem__Matrix__
#define __BusSystem__Matrix__

#include <stdio.h>
#include <queue>
#include <stack>
using namespace std;

struct ele{
    int i;
    bool reached = false;
};

struct node{
    int i;
    int d;
    int p;
    friend bool operator<(node n1, node n2){
        return n1.d > n2.d;
    }
};

struct element{
    int d;//权值
    char n;//线路号
    int interval;
};

class Matrix{
public:
    int NoEdge = 0;
    int n;//顶点数
    int e;//边数
    element **a;//二维数组
    
    //初始化没有边的图
    Matrix(int vertices=5, int noEdge=0);
    int Vertices(){return n;};
    int Edges(){return e;};
    void Add(int i, int j, int w, char n);
    void Add(int i, int j, int w, char n, int itv);
    void ShortestPaths(int s, int d[], int p[]);
    void RealPaths(int start, int end, stack<int> s, bool b[], int &min, string &path);
};



#endif /* defined(__BusSystem__Matrix__) */
