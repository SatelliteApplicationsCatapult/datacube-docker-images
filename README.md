# Open Data Cube Core Docker image

## Dockerfile
The provided [Dockerfile](Dockerfile) creates a Docker image with Open Data Cube Core v1.7 set up by means of Miniconda.

## Docker Compose
A [Docker Compose](docker-compose.yml) example file is provided to set up a fully functional Open Data Cube instance, including the underlying PostgreSQL 11.3 database.\
To use it you can issue:

```bash
docker-compose up -d
```

Once the above completes the Open Data Cube instance is ready to be initialized with:

```bash
docker-compose exec datacubecore datacube -v system init
```

The above prints out the following sort of logging on stdout:

```
2020-04-29 20:40:49,070 7 datacube INFO Running datacube command: /opt/conda/bin/datacube -v system init
Initialising database...
2020-04-29 20:40:49,459 7 datacube.drivers.postgres._core INFO Ensuring user roles.
2020-04-29 20:40:49,467 7 datacube.drivers.postgres._core INFO Creating schema.
2020-04-29 20:40:49,467 7 datacube.drivers.postgres._core INFO Creating tables.
2020-04-29 20:40:49,522 7 datacube.drivers.postgres._core INFO Adding role grants.
2020-04-29 20:40:49,524 7 datacube.index.index INFO Adding default metadata types.
Created.
Checking indexes/views.
2020-04-29 20:40:49,759 7 datacube.drivers.postgres._api INFO Checking dynamic views/indexes. (rebuild views=True, indexes=False)
Done.
```

You can then add products with e.g.:

```bash
docker-compose exec datacubecore datacube -v product add https://raw.githubusercontent.com/SatelliteApplicationsCatapult/odc-product-docker-images/master/datacube-product-definitions/ls_geomedian_annual.yaml
```

The above prints out the following sort of logging on stdout:

```
2020-04-29 20:41:00,446 20 datacube INFO Running datacube command: /opt/conda/bin/datacube -v product add https://raw.githubusercontent.com/SatelliteApplicationsCatapult/odc-product-docker-images/master/datacube-product-definitions/ls_geomedian_annual.yaml
2020-04-29 20:41:01,451 20 datacube.drivers.postgres._dynamic INFO Creating index: dix_ls8_geomedian_annual_lat_lon_time
2020-04-29 20:41:01,463 20 datacube.drivers.postgres._dynamic INFO Creating index: dix_ls8_geomedian_annual_time_lat_lon
Added "ls8_geomedian_annual"
2020-04-29 20:41:01,515 20 datacube.drivers.postgres._dynamic INFO Creating index: dix_ls7_geomedian_annual_lat_lon_time
2020-04-29 20:41:01,524 20 datacube.drivers.postgres._dynamic INFO Creating index: dix_ls7_geomedian_annual_time_lat_lon
Added "ls7_geomedian_annual"
2020-04-29 20:41:01,574 20 datacube.drivers.postgres._dynamic INFO Creating index: dix_ls5_geomedian_annual_lat_lon_time
2020-04-29 20:41:01,584 20 datacube.drivers.postgres._dynamic INFO Creating index: dix_ls5_geomedian_annual_time_lat_lon
Added "ls5_geomedian_annual"
2020-04-29 20:41:01,636 20 datacube.drivers.postgres._dynamic INFO Creating index: dix_ls4_geomedian_annual_lat_lon_time
2020-04-29 20:41:01,648 20 datacube.drivers.postgres._dynamic INFO Creating index: dix_ls4_geomedian_annual_time_lat_lon
Added "ls4_geomedian_annual"
```

You can then index some datasets with e.g.:

```bash
docker-compose exec datacubecore python /home/anaconda/dataset_index_from_s3_bucket.py public-eo-data -p common_sensing/fiji/landsat_8_geomedian/2019 --endpoint_url="http://s3-uk-1.sa-catapult.co.uk" --unsigned_requests --start_date 1960-01-01 --end_date 2030-01-01
```
