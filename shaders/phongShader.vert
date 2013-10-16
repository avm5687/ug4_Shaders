// Vertex Shader - acts at a per-vertex level
#version 120

uniform mat4 projectionMatrix, viewMatrix, modelMatrix;

attribute vec3 vertex_position, vertex_normal;
varying vec4 diffuse, ambientGlobal, ambient, position;
varying vec3 normal, reflection;

void main(void) {
    vec3 ka = vec3(0.50, 0.50, 0.50); // ambient reflectance
    vec3 Ia = vec3(1.00, 0.50, 0.00); // ambient light intensity
    vec3 materialAmbient = ka * Ia;

    vec3 Ip = vec3(0.50, 0.50, 0.50); // diffuse light intensity
    vec3 kd = vec3(0.85, 0.85, 0.85); // diffuse reflectivity
    vec3 materialDiffuse = Ip * kd;

    vec4 vertex = vec4(vertex_position, 1.0);

    normal = normalize(gl_NormalMatrix * vertex_normal);
    reflection = gl_LightSource[0].halfVector.xyz;
    position = viewMatrix * modelMatrix * vertex;

    ambient = vec4(materialAmbient, 1.0) * gl_LightSource[0].ambient;
    diffuse = vec4(materialDiffuse, 1.0) * gl_LightSource[0].diffuse;
    ambientGlobal = vec4(materialAmbient, 1.0) * gl_LightModel.ambient;

    gl_Position = projectionMatrix * viewMatrix * modelMatrix * vertex;
}
