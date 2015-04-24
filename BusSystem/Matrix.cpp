//
//  Matrix.cpp
//  BusSystem
//
//  Created by 董思言 on 15/4/3.
//  Copyright (c) 2015年 董思言. All rights reserved.
//

#include "Matrix.h"
#include <iostream>
using namespace std;

////创建矩阵二维数组
//void Make2DArray(int** a , int m, int n){
//    a = new int* [m];
//    for (int i=0; i<m; i++) {
//        a[i] = new int[n];
//    }
//}

//构造函数
Matrix::Matrix(int vertices, int noEdge){
    n = vertices;
    e = 0;
    NoEdge = noEdge;
    //Make2DArray(a, n+1, n+1);
    a = new element* [n+1];
    for (int i=0; i<n+1; i++) {
        a[i] = new element[n+1];
    }
    for (int i=1; i<=n; i++) {
        for (int j=1; j<=n; j++) {
            a[i][j].d = NoEdge;
        }
    }
}
//添加边
void Matrix::Add(int i, int j, int w, char n){
    if ( i<1 || j<1 || i>n || j>n || i==j ) {
        /*
         printf("参数有问题");
         if (i<1) cout<<i<<"<1";
         if (j<1) cout<<j<<"<1";
         if (i>n) cout<<i<<">n";
         if (j>n) cout<<j<<">n";
         if (i==j) cout<<"i==j";
         */
        return;
    }
    if (a[i][j].d!=NoEdge) {
        if (w<a[i][j].d) {
            a[i][j].d = w;
            a[j][i].d = w;
            a[i][j].n = n;
            a[j][i].n = n;
            e++;
        }
    }else{
        a[i][j].d = w;
        a[j][i].d = w;
        a[i][j].n = n;
        a[j][i].n = n;
        e++;
    }
    return;
}
//删除边

//最优路径
void Matrix::ShortestPaths(int s, int d[], int p[]){
    priority_queue<node> q;
    node *nd = new node[n+1];
    node now;
    now.i = s;
    now.d = 0;
    //初始化nd，q
    for (int i=1; i<=n; i++) {
        nd[i].i = i;
        nd[i].d = a[s][i].d;
        if (nd[i].d==NoEdge) {
            nd[i].p = 0;
        }else{
            nd[i].p = s;
            q.push(nd[i]);
        }
    }
    //更新p，nd的d
    while (!q.empty()) {
        now = q.top();
        q.pop();
        for (int j=1; j<=n; j++) {
            if (a[now.i][j].d!=NoEdge){
                if (nd[j].p==0) {
                    nd[j].d = now.d + a[now.i][j].d;
                    q.push(nd[j]);
                    nd[j].p = now.i;
                }
                if (nd[j].d>now.d+a[now.i][j].d) {
                    nd[j].d = now.d + a[now.i][j].d;
                    nd[j].p = now.i;
                }
            }
        }
    }
    for (int i=1; i<=n; i++) {
        d[i] = nd[i].d;
        p[i] = nd[i].p;
    }
    d[s] = 0;
    p[s] = 0;
}

//找出所有路径
void Matrix::AllPaths(int start, int end, stack<int> s, bool b[]){
    s.push(start);
    b[start] = true;
    
    if (start==end) {
        stack<int> stkOut, temp;
        while (!s.empty()) {
            stkOut.push(s.top());
            temp.push(s.top());
            s.pop();
        }
        while (!temp.empty()) {
            s.push(temp.top());
            temp.pop();
        }
        cout<<"线路：";
        while (!stkOut.empty()) {
            cout<<" "<<stkOut.top();//待做 车站之间加线路编号
            stkOut.pop();
        }
        cout<<endl;
    }
    
    for (int i=1; i<=n; i++) {
        if (a[start][i].d!=NoEdge && !b[i]) {
            AllPaths(i, end, s, b);
        }
    }
    
    b[start] = false;
    
}
