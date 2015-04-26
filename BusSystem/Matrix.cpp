//
//  Matrix.cpp
//  BusSystem
//
//  Created by 董思言 on 15/4/3.
//  Copyright (c) 2015年 董思言. All rights reserved.
//

#include "Matrix.h"
#include <iostream>
#include "string.h"
#include <sstream>
using namespace std;

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
        a[i][j].d = w ;
        a[j][i].d = w;
        a[i][j].n = n;
        a[j][i].n = n;
        e++;
    }
    return;
}

void Matrix::Add(int i, int j, int w, char n, int itv){
    if ( i<1 || j<1 || i>n || j>n || i==j ) {
        return;
    }
    if (a[i][j].d!=NoEdge) {
        if (w<a[i][j].d) {
            a[i][j].d = w;
            a[j][i].d = w;
            a[i][j].n = n;
            a[j][i].n = n;
            e++;
            a[i][j].interval = itv;
            a[j][i].interval = itv;
        }
    }else{
        a[i][j].d = w;
        a[j][i].d = w;
        a[i][j].n = n;
        a[j][i].n = n;
        e++;
        a[i][j].interval = itv;
        a[j][i].interval = itv;
    }
    return;
}

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

//找出真实路径
// b初值为false min初值为无穷大 path初值为'\0'
void Matrix::RealPaths(int start, int end, stack<int> s, bool b[], int &min, string &path){
    s.push(start);
    b[start] = true;
    //找到一条路径
    if (start==end) {
        char station[17];
        station[0] = '0';
        station[1] = 'A';
        station[2] = 'B';
        station[3] = 'C';
        station[4] = 'D';
        station[5] = 'E';
        station[6] = 'F';
        station[7] = 'G';
        station[8] = 'H';
        station[9] = 'I';
        station[10] = 'J';
        station[11] = 'K';
        station[12] = 'L';
        station[13] = 'M';
        station[14] = 'N';
        station[15] = 'O';
        station[16] = 'P';

        stack<int> stkOut, temp;
        char staTemp = '\0';
        char numTemp = '\0';
        int speedSum = 0;
        //ostringstream oss;

        string cstring = "";
        while (!s.empty()) {
            stkOut.push(s.top());
            temp.push(s.top());
            s.pop();
        }
        while (!temp.empty()) {
            s.push(temp.top());
            temp.pop();
        }
        
        //输出线路
        while (!stkOut.empty()) {
            if (staTemp!='\0') {
                if (numTemp!='\0'&&numTemp!=a[staTemp][stkOut.top()].n) {
                    speedSum += a[staTemp][stkOut.top()].interval-48;
                }
                cstring = cstring + ">-" + a[staTemp][stkOut.top()].n + "->";
                speedSum += a[staTemp][stkOut.top()].d-48;
                numTemp = a[staTemp][stkOut.top()].n;
            }
            
            for (int i=0; i<17; i++) {
                if (i==stkOut.top()) {
                    cstring += station[i];
                }
            }
            staTemp = stkOut.top();
            stkOut.pop();
        }
        cout<<"线路："<<cstring<<"\n时间："<<speedSum<<"min"<<endl;
        if (speedSum<min) {
            ostringstream oss;
            oss<<speedSum;
            string speedPass = oss.str();
            path = "线路：" + cstring + "\n时间：" + speedPass + "min";
            min = speedSum;
        }
    }
    
    for (int i=1; i<=n; i++) {
        if (a[start][i].d!=NoEdge && !b[i]) {
            RealPaths(i, end, s, b, min, path);
        }
    }
    
    b[start] = false;
    
}
