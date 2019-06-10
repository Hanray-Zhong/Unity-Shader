// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Unity Shaders Book/Chapter 5/Simple Shader" {
	Properties {
		_Color ("Color Tint", Color) = (1, 1, 1, 1)
	}
    SubShader {
        Pass {
            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            fixed4 _Color;

            // a2v => application to vertex shader
			struct a2v {
                float4 vertex : POSITION;
				float3 normal : NORMAL;
				float4 texcoord : TEXCOORD0;
            };
            // v2f => vertex shader to fragment shader
            struct v2f {
                float4 pos : SV_POSITION;
                fixed3 color : COLOR0;
            };
            
            v2f vert (a2v v)
	        {
	            v2f o;
                o.pos = UnityObjectToClipPos (v.vertex);
                // 将每一个顶点的法线[-1, 1]映射到[0, 1]作为颜色传递给片元着色器
                o.color = v.normal * 0.5 + fixed3(0.5, 0.5, 0.5);
                // o.color = fixed3(1, 1, 1);
                return o;
	        }
	
	        fixed4 frag(v2f i) : SV_Target {
            	fixed3 c = i.color;
                // 使用属性中的Color控制最终输出的颜色
                c *= _Color.rgb;
                return fixed4(c, 1.0);
            }

            ENDCG
        }
    }
}