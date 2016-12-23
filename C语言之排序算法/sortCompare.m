//
//  sortCompare.m
//  Function Model
//
//  Created by foscom on 16/7/23.
//  Copyright © 2016年 foscam. All rights reserved.
//

#import "sortCompare.h"

@implementation sortCompare


int* bubble(int*a,int n)
{
    int i,j,temp;
    
    for (i=0; i<n; i++) {
        
        for (j=0; j<n-i-1; j++) {
            
            if (a[j] > a[j+1]) {
                temp = a[j];
                a[j]=a[j+1];
                a[j+1]=temp;
            }
        }
        
        
    }
    
    return a;
    
}

int * selecte(int *b,int n)
{
    
    int i,j,k,temp;
    
    for (i=0; i<n-1; i++) {
        
        k = i;
        for (j=i+1; j<n; j++) {
            
            if (b[j]<b[k]) {
                
                k=j;
                temp=b[k];
                b[k]=b[i];
                b[i]=temp;

            }
            
        }
        
    }
    
    return b;
}



@end
