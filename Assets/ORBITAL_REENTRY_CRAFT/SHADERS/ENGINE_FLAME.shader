// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

// Shader created with Shader Forge Beta 0.36 
// Shader Forge (c) Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:0.36;sub:START;pass:START;ps:flbk:,lico:1,lgpr:1,nrmq:1,limd:1,uamb:True,mssp:True,lmpd:False,lprd:False,enco:False,frtr:True,vitr:True,dbil:False,rmgx:True,rpth:0,hqsc:True,hqlp:False,tesm:0,blpr:1,bsrc:3,bdst:7,culm:0,dpts:2,wrdp:False,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0,f2p0:False;n:type:ShaderForge.SFN_Final,id:1,x:32146,y:32542|diff-11-RGB,emission-394-OUT,alpha-357-OUT;n:type:ShaderForge.SFN_Panner,id:4,x:33487,y:32683,spu:0,spv:1.5;n:type:ShaderForge.SFN_Fresnel,id:5,x:33277,y:33081|EXP-284-OUT;n:type:ShaderForge.SFN_Tex2d,id:6,x:33278,y:32676,ptlb:Noise Texture,ptin:_NoiseTexture,tex:3f5802bf8070604439bda876b7c70e89,ntxv:0,isnm:False|UVIN-4-UVOUT;n:type:ShaderForge.SFN_Color,id:11,x:33478,y:32297,ptlb:Main Color,ptin:_MainColor,glob:False,c1:0.608564,c2:0.9073499,c3:0.9852941,c4:1;n:type:ShaderForge.SFN_Multiply,id:54,x:32761,y:32642|A-405-OUT,B-145-OUT;n:type:ShaderForge.SFN_ValueProperty,id:59,x:33592,y:32509,ptlb:Emissive Mult,ptin:_EmissiveMult,glob:False,v1:2;n:type:ShaderForge.SFN_VertexColor,id:83,x:33264,y:32857;n:type:ShaderForge.SFN_Multiply,id:84,x:32837,y:32887|A-6-R,B-83-A,C-164-OUT;n:type:ShaderForge.SFN_Multiply,id:145,x:33020,y:32683|A-11-RGB,B-6-R;n:type:ShaderForge.SFN_OneMinus,id:164,x:33071,y:33081|IN-5-OUT;n:type:ShaderForge.SFN_Vector1,id:185,x:33682,y:33101,v1:0.25;n:type:ShaderForge.SFN_Exp,id:284,x:33474,y:33101,et:1|IN-185-OUT;n:type:ShaderForge.SFN_Multiply,id:357,x:32566,y:32919|A-84-OUT,B-164-OUT;n:type:ShaderForge.SFN_TexCoord,id:392,x:32879,y:32744,uv:0;n:type:ShaderForge.SFN_Color,id:393,x:33106,y:32389,ptlb:Mult Color,ptin:_MultColor,glob:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:394,x:32526,y:32621|A-393-RGB,B-54-OUT,C-392-V;n:type:ShaderForge.SFN_Exp,id:405,x:33375,y:32509,et:0|IN-59-OUT;proporder:6-11-59-393;pass:END;sub:END;*/

Shader "Shader Forge/TEST" {
    Properties {
        _NoiseTexture ("Noise Texture", 2D) = "white" {}
        _MainColor ("Main Color", Color) = (0.608564,0.9073499,0.9852941,1)
        _EmissiveMult ("Emissive Mult", Float ) = 2
        _MultColor ("Mult Color", Color) = (0.5,0.5,0.5,1)
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "ForwardBase"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma exclude_renderers xbox360 ps3 flash d3d11_9x 
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform float4 _TimeEditor;
            uniform sampler2D _NoiseTexture; uniform float4 _NoiseTexture_ST;
            uniform float4 _MainColor;
            uniform float _EmissiveMult;
            uniform float4 _MultColor;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float4 vertexColor : COLOR;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.normalDir = mul(float4(v.normal,0), unity_WorldToObject).xyz;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
/////// Normals:
                float3 normalDirection =  i.normalDir;
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
////// Lighting:
                float attenuation = 1;
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float NdotL = dot( normalDirection, lightDirection );
                float3 diffuse = max( 0.0, NdotL) * attenColor + UNITY_LIGHTMODEL_AMBIENT.rgb;
////// Emissive:
                float4 node_443 = _Time + _TimeEditor;
                float2 node_4 = (i.uv0.rg+node_443.g*float2(0,1.5));
                float4 node_6 = tex2D(_NoiseTexture,TRANSFORM_TEX(node_4, _NoiseTexture));
                float3 emissive = (_MultColor.rgb*(exp(_EmissiveMult)*(_MainColor.rgb*node_6.r))*i.uv0.g);
                float3 finalColor = 0;
                float3 diffuseLight = diffuse;
                finalColor += diffuseLight * _MainColor.rgb;
                finalColor += emissive;
                float node_164 = (1.0 - pow(1.0-max(0,dot(normalDirection, viewDirection)),exp2(0.25)));
/// Final Color:
                return fixed4(finalColor,((node_6.r*i.vertexColor.a*node_164)*node_164));
            }
            ENDCG
        }
        Pass {
            Name "ForwardAdd"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            ZWrite Off
            
            Fog { Color (0,0,0,0) }
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd
            #pragma exclude_renderers xbox360 ps3 flash d3d11_9x 
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform float4 _TimeEditor;
            uniform sampler2D _NoiseTexture; uniform float4 _NoiseTexture_ST;
            uniform float4 _MainColor;
            uniform float _EmissiveMult;
            uniform float4 _MultColor;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float4 vertexColor : COLOR;
                LIGHTING_COORDS(3,4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.normalDir = mul(float4(v.normal,0), unity_WorldToObject).xyz;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
/////// Normals:
                float3 normalDirection =  i.normalDir;
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float NdotL = dot( normalDirection, lightDirection );
                float3 diffuse = max( 0.0, NdotL) * attenColor;
                float3 finalColor = 0;
                float3 diffuseLight = diffuse;
                finalColor += diffuseLight * _MainColor.rgb;
                float4 node_445 = _Time + _TimeEditor;
                float2 node_4 = (i.uv0.rg+node_445.g*float2(0,1.5));
                float4 node_6 = tex2D(_NoiseTexture,TRANSFORM_TEX(node_4, _NoiseTexture));
                float node_164 = (1.0 - pow(1.0-max(0,dot(normalDirection, viewDirection)),exp2(0.25)));
/// Final Color:
                return fixed4(finalColor * ((node_6.r*i.vertexColor.a*node_164)*node_164),0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
