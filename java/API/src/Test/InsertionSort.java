package Test;
/**
 * 插入排序：直接插入排序，希尔排序
 * @author soft01
 *
 */
public class InsertionSort {
	//直接插入排序，希尔排序
	public void straightlnsertionSort(double[] sorted){
		//获取数组长度
		int sortedLen=sorted.length;
		//从第3位开始循环
		for(int j=2;j<sortedLen;j++){
			//当前一位小于后一位，时
			if(sorted[j]<sorted[j-1]){
				//将值保存给0
				sorted[0]=sorted[j];
				sorted[j]=sorted[j-1];
				int insertPos=0;
				for(int k=j-2;k>=0;k--){
					if(sorted[k]>sorted[0]){
						sorted[k+1]=sorted[k];
					}else{
						insertPos=k+1;
						break;
					}
				}
				sorted[insertPos]=sorted[0];
			}
		}
	}
	
	public void shelllnertionSort(double[]sorted,int inc){
		int sortedLen=sorted.length;
		for(int j=inc+1;j<sortedLen;j++){
			if(sorted[j]<sorted[j-inc]){
				sorted[0]=sorted[j];
				
				int insertPos=j;
				for(int k=j-inc;k>=0;k-=inc){
					if(sorted[k]>sorted[0]){
						sorted[k+inc]=sorted[k];
						
						if(k-inc<=0){
							insertPos=k;
						}
					}else{
						insertPos=k+inc;
						break;
					}
				}
				sorted[insertPos]=sorted[0];
			}
		}
	}
	
	
}
