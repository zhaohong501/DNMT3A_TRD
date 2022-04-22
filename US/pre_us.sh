#!bin/bash
root='/home/zhaohong/zh/result3/us_add/window0.5_noallrestraint'
cd ${root}
for i in {'5','10','20','30','40','50'}
do
	
	cd ${root}
	mkdir ${i}
	cd ${i}
	echo `pwd`
	cp ../genwhamin.sh ./
	cp ../run_wham.sh ./
	sed -i 's/40/'${i}'/g' run_wham.sh
	num=500000
	va=$((${i}*${num}))
	echo $va
	for m in $(seq -w 00 39)
	do
		awk -v va="$va" '{if($1 < va) print $0}' ../window-${m}-01.dat>window-${m}-01.dat
	done
	bash genwhamin.sh
	bash run_wham.sh
	cp ./pmf* ../
done
