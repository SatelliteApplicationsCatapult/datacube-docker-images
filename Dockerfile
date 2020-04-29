FROM continuumio/miniconda3:4.8.2-alpine

LABEL maintainer="Luigi Di Fraia"

ENV PATH /opt/conda/bin:$PATH

RUN conda install --yes \
    python=3.6 \
    && conda clean -tipsy \
    && find /opt/conda/ -type f -name '*.a' -delete \
    && find /opt/conda/ -type f -name '*.pyc' -delete \
    && find /opt/conda/ -type f -name '*.js.map' -delete \
    && rm -rf /opt/conda/pkgs

RUN conda install --yes \
    -c conda-forge \
    boto3==1.12.48 \
    dask==2.14.0 \
    datacube==1.7 \
    distributed==2.14.0 \
    gdal==2.4.4 \
    && conda clean -tipsy \
    && find /opt/conda/ -type f -name '*.a' -delete \
    && find /opt/conda/ -type f -name '*.pyc' -delete \
    && find /opt/conda/ -type f -name '*.js.map' -delete \
    && rm -rf /opt/conda/pkgs

COPY datacube.conf /etc/datacube.conf

RUN conda install --yes \
    -c conda-forge \
    ruamel.yaml==0.16.10 \
    && conda clean -tipsy \
    && find /opt/conda/ -type f -name '*.a' -delete \
    && find /opt/conda/ -type f -name '*.pyc' -delete \
    && find /opt/conda/ -type f -name '*.js.map' -delete \
    && rm -rf /opt/conda/pkgs

COPY dataset_index_from_s3_bucket.py /home/anaconda/dataset_index_from_s3_bucket.py

CMD ["tail", "-f", "/dev/null"]
