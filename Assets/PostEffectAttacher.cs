using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Networking.Types;

public class PostEffectAttacher : MonoBehaviour
{
    public Shader shader;
    private Material material;

    private void Awake()
    {
        //shaderを割り当てたマテリアルの動的生成
        material = new Material(shader);
    }

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        Graphics.Blit(source, destination, material);        
    }
   
}
