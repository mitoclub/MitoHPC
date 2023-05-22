## Steps to build docker container:

```bash
git clone https://github.com/mitoclub/MitoHPC.git
cd MitoHPC
docker build -t mitohpc .
```

## Steps to run example data:

```bash
PATH_TO_TEST_WORKDIR=/.../MitoHPC/test
docker run -ti -v $PATH_TO_TEST_WORKDIR:/test

#inside container
cd /test
cp -r /MitoHPC/examples1/bams .
cp /MitoHPC/scripts/init.sh .
. init.sh 
$HP_SDIR/run.sh > run.all.sh
bash ./run.all.sh
```
