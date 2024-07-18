## Prerequisites

List of software and versions required before installation:
- Docker

## Getting Started
To start using the docker container you just need to pull it from 
```shell
docker pull ghcr.io/damintsew/simple-elastix-base:latest
```
Or if you prefer from Docker hub you can use this command 
```shell
docker pull docker.io/damintsew/simple-elastix-base:latest
```

### Usage

Basically you just have to import SimpleITK and Elastix in your python code, and you are good to go. 
```python
import SimpleITK as sitk
print(sitk.Version())
```

How to check if everything inside container works properly :
- Run Docker container:

 ``` shell
 docker run -it --rm damintsew/simple-elastix-base:latest  sh -c "sleep 99999"
   ```
 - Step into the container:
 ``` shell  
 docker exec -it <container_id> sh
```
- Run python code:
``` shell python
python 
import SimpleITK as sitk
print(sitk.Version())
```

## Building the Docker Image

Steps to build the Docker image:
1. Run the following command in the project directory:
    ```sh
    docker build -t your-image-name .
    ```

## License

This project is licensed under the Apache 2.0 License.
