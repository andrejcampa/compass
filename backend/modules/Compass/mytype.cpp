#include "mytype.h"
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <iostream>
#include <fstream>
#include <math.h>

using namespace std;

MyType::MyType(QObject *parent) :
    QObject(parent),
    m_message("test")
{
    //ifstream myfile ("/home/phablet/.local/share/compass/calibration.txt",ios::in);
    //ifstream myfile ("calibration.txt",ios::in);
    ifstream myfile ("/tmp/calibration.kwek");
    if (myfile.is_open())
     {
          myfile>>x_offset;
          myfile>>y_offset;
          myfile>>x_ampl;
          myfile>>y_ampl;
          myfile.close();
    }

}

int MyType::launch()
{

    QString output="test1";
    ifstream myfile ("/sys/devices/platform/msensor/driver/sensordata", ios::in );
    if (myfile.is_open())
     {
          int x_pos=0;
          int y_pos=0;
          myfile>>x_pos;
          myfile>>y_pos;
          myfile.close();
          x_pos=x_pos-x_offset-x_ampl/2;
          y_pos=y_pos-y_offset-y_ampl/2;

    return (int)(atan2(x_pos,(y_pos+0.01))*180.0/3.14)+(x_pos<0)*360;
    }
    return -1;
}

QString MyType::calibrate()
{
    int xmax,ymax;
    int xmin, ymin;
    xmax=-10000;
    ymax=-10000;
    xmin=10000;
    ymin=10000;

    int zacasen;
    for(int i=100;i>0;i--){
        ifstream myfile ("/sys/devices/platform/msensor/driver/sensordata", ios::in );
        myfile>>zacasen;
        if (zacasen>xmax) xmax=zacasen;
        if (zacasen<xmin) xmin=zacasen;
        myfile>>zacasen;
        if (zacasen>ymax) ymax=zacasen;
        if (zacasen<ymin) ymin=zacasen;
        usleep(30000);
        myfile.close();
        usleep(30000);
    }

    QString output="calibration failed!";
    //ofstream myfile ("/home/phablet/.local/share/compass/calibration.txt");
    //ofstream myfile ("calibration.txt");
    ofstream myfile ("/tmp/calibration.kwek");
    if (myfile.is_open())
     {
          myfile<<xmin<<"\t";
          myfile<<ymin<<"\n";
          myfile<<xmax-xmin<<"\t";
          myfile<<ymax-ymin<<"\n";
          myfile.close();
    output = "calibration finished";
    }
    x_offset=xmin;
    y_offset=ymin;
    x_ampl=xmax-xmin;
    y_ampl=ymax-ymin;
    return output;
}

MyType::~MyType() {

}

