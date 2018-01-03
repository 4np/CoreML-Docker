# Converting a Model file to CoreML

The docker image comes out of the box with a couple of example models and convertion scripts. To build and run:

```
./build-and-run.sh
```

When the container is running, navigate to [notebooks/notebook/Convert Karas Model.ipynb](http://0.0.0.0:8888/notebooks/notebook/Convert%20Food%20101%20Karas%20Model.ipynb) and execute the script blocks (`control-enter`), this will:

- download the Food 101 Keras model and labels (to [/models](http://0.0.0.0:8888/tree/models))
- convert the Food 101 Keras model to a CoreML model (to [the root](http://0.0.0.0:8888/tree))


## Customization

While the example notebook that converts the Food 101 Keras model to a CoreML model works out of the box, you might find it more convenient to directly download the model files when building the Docker image. You can download them in the `Dockerfile` by adding these lines after the workspace directory is created:

```
# Download example Food101 Keras model weights and labels
RUN wget -O /workspace/models/keras-food101-model.hdf5 https://s3.amazonaws.com/stratospark/food-101/model4b.10-0.68.hdf5
RUN wget -O /workspace/models/keras-food101-model-labels.txt https://github.com/stratospark/food-101-mobile/raw/43598fdc08500683bbc04f877ae069c38c8ac4c3/model_export/labels.txt
``` 

### Build the Docker Image
To build a docker image using a DockerFile, issue the following command:

```
docker build -t convert-coreml .
```

### Run docker container

Run the docker container using the image you just built: 

```
docker run --rm -it -p 8888:8888 -v $(pwd)/notebook:/workspace/notebook convert-coreml
```

`—-rm`: when finished using this container, remove it and clean it up

`—it`: open an interactive shell when the container starts

`-p local-port:container-port`: forward our local port to the container’s port 

`-v local-dir:container-dir`: mount a local volume in the container

### Launch Jupyter

Browse to [https://localhost:8888](https://localhost:8888) and check out the [notebooks](http://0.0.0.0:8888/tree/notebook).

## Additional Resources

- [Deep learning food classification demo with Keras](http://blog.stratospark.com/deep-learning-applied-food-classification-deep-learning-keras.html) by Stratospark
- Udacity's free [Core ML: Machine Learning of iOS](https://www.udacity.com/course/core-ml--ud1038) course is a great introduction.

# License

See the accompanying [LICENSE](LICENSE) file for more information.

```
Copyright 2018 Jeroen Wesbeek

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```