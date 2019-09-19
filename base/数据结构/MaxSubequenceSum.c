
/**
 * 最大子列和问题：
 * 给定N个整数的序列{A0,A1,A2,...,An},求最大子列和。若为负数，则返回0
*/

int MaxSubsequSum1(int [],int);
int MaxSubsequSum2(int [],int);
int MaxSubsequSum3(int [],int);
int MaxSubsequSum4(int [],int);


int maxSumRec(int list[],int left,int right);


int main() {
    return 0;
}

//方法1:暴力枚举
//复杂度 ： T(N) = O(N^3)
int MaxSubsequSum1(int list[],int n){
    int thisSum,maxSum = 0;
    int i,j,k=0;
    for(i = 0;i < n;i++){
        for(j = i;j<n;j++){
            thisSum = 0;
            for(k = i;k<= j; k++){
                thisSum += list[k];
                if(thisSum > maxSum){
                    maxSum = thisSum;
                }
            }
        }
    }
    return maxSum;
}

//方法2:暴力枚举
//复杂度 ： T(N) = O(N^2)
int MaxSubsequSum2(int list[],int n){
    int thisSum,maxSum = 0;
    int i,j=0;
    for(i = 0;i < n;i++){
        thisSum = 0;
        for(j = i;j<n;j++){
                thisSum += list[j];
                if(thisSum > maxSum){
                    maxSum = thisSum;
                }
            }
        }
    return maxSum;
}

//方法3:分而治之
//复杂度：O(n) = nlogn
int MaxSubsequSum3(int list[],int n){
    return maxSumRec(list,0,n-1);
}

int maxSumRec(int list[],int left,int right){
    if(left == right){
        if(list[left] > 0) return list[left];
        else return 0;
    }

    //分
    int mid = (left + right) / 2;
    int maxLeftSum = maxSumRec(list,left,mid);
    int maxRightSum = maxSumRec(list,mid+1,right);

    //跨分界线求最大子列和
    int leftBorderSum , maxLeftBorderSum = 0;
    leftBorderSum = maxLeftBorderSum = 0;
    for(int i = mid;i >= left; i--){
        leftBorderSum += list[i];
        if (leftBorderSum > maxLeftBorderSum)
            maxLeftBorderSum = leftBorderSum;
    }

    // 求出右半部分包含第一个元素的最大子序列和
    int rightBorderSum = 0, maxRightBorderSum = 0;
    rightBorderSum = maxRightBorderSum = 0;
    for (int j = mid + 1; j <= right; j++){
        rightBorderSum += list[j];
        if (rightBorderSum > maxRightBorderSum)
            maxRightBorderSum = rightBorderSum;
    }

    int max = maxLeftBorderSum + maxRightBorderSum;
    max = max > maxLeftSum ? max : maxLeftSum;
    return max > maxRightSum ? max : maxRightSum;
}

//在线处理
//复杂度：T(N) = O(N)
int MaxSubsequSum4(int list[],int n) {
    int thisSum,maxSum = 0;
    int i;
    thisSum = maxSum = 0;
    for(int i = 0;i < n ;i++){
        thisSum += list[i];
        if(thisSum > maxSum){
            maxSum = thisSum;
        }else if(thisSum < 0){
            thisSum = 0;
        }
    }
    return maxSum;
}