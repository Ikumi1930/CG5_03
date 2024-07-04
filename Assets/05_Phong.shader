Shader "Unlit/NewUnlitShader"
{
	Properties{_Color("Color", Color) = (1, 0, 0, 1)} SubShader
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "Lighting.cginc" //光源情報を取得するのに必要なinclude
			#include "UnityCG.cginc"

			fixed4 _Color;

			struct appdata // appdataという構造体を宣言
			{
				float4 vertex : POSITION; // 構造体にはセマンティクスが必要
				float3 normal : NORMAL;   // 法線情報(NORMAL)用のセマンティクス
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float3 worldPosition : TEXCOORD1;
				float3 normal : NORMAL;
			};

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.worldPosition = mul(unity_ObjectToWorld, v.vertex);
				o.normal = UnityObjectToWorldNormal(v.normal);
				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				float intensity = saturate(dot(normalize(i.normal), _WorldSpaceLightPos0));

				fixed4 color = fixed4(1, 1, 1, 1);
				fixed4 diffuse = _Color * intensity * _LightColor0;

				float3 eyeDir = normalize(_WorldSpaceCameraPos.xyz - i.worldPosition);
				float3 lightDir = normalize(_WorldSpaceLightPos0);
				i.normal = normalize(i.normal);
				float3 reflectDir = -lightDir + 2 * i.normal * dot(i.normal, lightDir);
				fixed4 specular = pow(saturate(dot(reflectDir, eyeDir)), 20) * _LightColor0;

				fixed4 ambient = _Color * 0.3 * _LightColor0;

				fixed4 phong = ambient + diffuse + specular;

				return phong;
			}
			ENDCG
		}
	}
}
