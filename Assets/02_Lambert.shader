Shader "Unlit/02_Lambert" {
	Properties{_Color("Color", Color) = (1, 0, 0, 1)}

	SubShader {
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "Lighting.cginc" //���������擾����̂ɕK�v��include
			#include "UnityCG.cginc"

			fixed4 _Color;

			struct appdata // appdata�Ƃ����\���̂�錾
			{
				float4 vertex : POSITION; // �\���̂ɂ̓Z�}���e�B�N�X���K�v
				float3 normal : NORMAL;   // �@�����(NORMAL)�p�̃Z�}���e�B�N�X
			};

			struct v2f {
				float4 vertex : SV_POSITION;
				float3 normal : NORMAL;
			};

			v2f vert(appdata v) {
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.normal = UnityObjectToWorldNormal(v.normal);
				return o;
			}

			fixed4 frag(v2f i) : SV_Target {
				float intensity = saturate(dot(normalize(i.normal), _WorldSpaceLightPos0));

				fixed4 color = fixed4(1, 1, 1, 1);
				fixed4 diffuse = _Color * intensity * _LightColor0;
			

				return diffuse;
			}
			ENDCG
		}
	}
}
