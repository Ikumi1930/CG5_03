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
        //shader�����蓖�Ă��}�e���A���̓��I����
        material = new Material(shader);
    }

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        Graphics.Blit(source, destination, material);        
    }
   
}
