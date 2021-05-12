Shader "NatureManufacture/URP/Layered/Layered"
    {
        Properties
        {
            _AlphaCutoff("Alpha Cutoff", Range(0, 1)) = 0
            _BaseColor("Base Color", Color) = (1, 1, 1, 0)
            [NoScaleOffset]_BaseColorMap("Base Map(RGB) Alpha(A)", 2D) = "white" {}
            [ToggleUI]_BaseUsePlanarUV("Base Use Planar UV", Float) = 0
            _BaseTilingOffset("Base Tiling and Offset", Vector) = (1, 1, 0, 0)
            [NoScaleOffset]_BaseNormalMap("Base Normal Map", 2D) = "bump" {}
            _BaseNormalScale("Base Normal Scale", Range(0, 8)) = 1
            [NoScaleOffset]_BaseMaskMap("Base Mask Map MT(R) AO(G) H(B) SM(A)", 2D) = "white" {}
            _BaseMetallic("Base Metallic", Range(0, 1)) = 1
            _BaseAORemapMin("Base AO Remap Min", Range(0, 1)) = 0
            _BaseAORemapMax("Base AO Remap Max", Range(0, 1)) = 1
            _BaseSmoothnessRemapMin("Base Smoothness Remap Min", Range(0, 1)) = 0
            _BaseSmoothnessRemapMax("Base Smoothness Remap Max", Range(0, 1)) = 1
            [NoScaleOffset]_LayerMask("Layer Mask (R)", 2D) = "black" {}
            [ToggleUI]_Invert_Layer_Mask("Invert Layer Mask", Float) = 0
            _Height_Transition("Height Blend Transition", Range(0.001, 1)) = 1
            _HeightMin("Height Min", Float) = 0
            _HeightMax("Height Max", Float) = 1
            _HeightOffset("Height Offset", Float) = 0
            _HeightMin2("Height 2 Min", Float) = 0
            _HeightMax2("Height 2 Max", Float) = 1
            _HeightOffset2("Height 2 Offset", Float) = 0
            _Base2Color("Base 2 Color", Color) = (1, 1, 1, 0)
            [NoScaleOffset]_Base2ColorMap("Base 2 Map", 2D) = "white" {}
            _Base2TilingOffset("Base 2 Tiling and Offset", Vector) = (1, 1, 0, 0)
            [ToggleUI]_Base2UsePlanarUV("Base 2 Use Planar UV", Float) = 0
            [NoScaleOffset]_Base2NormalMap("Base 2 Normal Map", 2D) = "bump" {}
            _Base2NormalScale("Base 2 Normal Scale", Range(0, 8)) = 1
            [NoScaleOffset]_Base2MaskMap("Base 2 Mask Map MT(R) AO(G) H(B) SM(A)", 2D) = "white" {}
            _Base2Metallic("Base 2 Metallic", Range(0, 1)) = 1
            _Base2SmoothnessRemapMin("Base 2 Smoothness Remap Min", Range(0, 1)) = 0
            _Base2SmoothnessRemapMax("Base 2 Smoothness Remap Max", Range(0, 1)) = 1
            _Base2AORemapMin("Base 2 AO Remap Min", Range(0, 1)) = 0
            _Base2AORemapMax("Base 2 AO Remap Max", Range(0, 1)) = 1
            _WetColor("Wet Color Vertex(R)", Color) = (0.7735849, 0.7735849, 0.7735849, 0)
            _WetSmoothness("Wet Smoothness Vertex(R)", Range(0, 1)) = 1
            [HideInInspector][NoScaleOffset]unity_Lightmaps("unity_Lightmaps", 2DArray) = "" {}
            [HideInInspector][NoScaleOffset]unity_LightmapsInd("unity_LightmapsInd", 2DArray) = "" {}
            [HideInInspector][NoScaleOffset]unity_ShadowMasks("unity_ShadowMasks", 2DArray) = "" {}
        }
        SubShader
        {
            Tags
            {
                "RenderPipeline"="UniversalPipeline"
                "RenderType"="Opaque"
                "UniversalMaterialType" = "Lit"
                "Queue"="AlphaTest"
            }
            Pass
            {
                Name "Universal Forward"
                Tags
                {
                    "LightMode" = "UniversalForward"
                }
    
                // Render State
                Cull Back
                Blend One Zero
                ZTest LEqual
                ZWrite On
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 4.5
                #pragma exclude_renderers gles gles3 glcore
                #pragma multi_compile_instancing
                #pragma multi_compile_fog
                #pragma multi_compile _ DOTS_INSTANCING_ON
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                #pragma multi_compile _ _SCREEN_SPACE_OCCLUSION
                #pragma multi_compile _ LIGHTMAP_ON
                #pragma multi_compile _ DIRLIGHTMAP_COMBINED
                #pragma multi_compile _ _MAIN_LIGHT_SHADOWS
                #pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
                #pragma multi_compile _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS _ADDITIONAL_OFF
                #pragma multi_compile _ _ADDITIONAL_LIGHT_SHADOWS
                #pragma multi_compile _ _SHADOWS_SOFT
                #pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
                #pragma multi_compile _ SHADOWS_SHADOWMASK
                // GraphKeywords: <None>
    
                // Defines
                #define _AlphaClip 1
                #define _NORMALMAP 1
                #define _NORMAL_DROPOFF_TS 1
                #define ATTRIBUTES_NEED_NORMAL
                #define ATTRIBUTES_NEED_TANGENT
                #define ATTRIBUTES_NEED_TEXCOORD0
                #define ATTRIBUTES_NEED_TEXCOORD1
                #define ATTRIBUTES_NEED_COLOR
                #define VARYINGS_NEED_POSITION_WS
                #define VARYINGS_NEED_NORMAL_WS
                #define VARYINGS_NEED_TANGENT_WS
                #define VARYINGS_NEED_TEXCOORD0
                #define VARYINGS_NEED_COLOR
                #define VARYINGS_NEED_VIEWDIRECTION_WS
                #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_FORWARD
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    float3 positionOS : POSITION;
                    float3 normalOS : NORMAL;
                    float4 tangentOS : TANGENT;
                    float4 uv0 : TEXCOORD0;
                    float4 uv1 : TEXCOORD1;
                    float4 color : COLOR;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                };
                struct Varyings
                {
                    float4 positionCS : SV_POSITION;
                    float3 positionWS;
                    float3 normalWS;
                    float4 tangentWS;
                    float4 texCoord0;
                    float4 color;
                    float3 viewDirectionWS;
                    #if defined(LIGHTMAP_ON)
                    float2 lightmapUV;
                    #endif
                    #if !defined(LIGHTMAP_ON)
                    float3 sh;
                    #endif
                    float4 fogFactorAndVertexLight;
                    float4 shadowCoord;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    float3 WorldSpaceNormal;
                    float3 TangentSpaceNormal;
                    float3 WorldSpaceTangent;
                    float3 WorldSpaceBiTangent;
                    float3 AbsoluteWorldSpacePosition;
                    float4 uv0;
                    float4 VertexColor;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 ObjectSpacePosition;
                };
                struct PackedVaryings
                {
                    float4 positionCS : SV_POSITION;
                    float3 interp0 : TEXCOORD0;
                    float3 interp1 : TEXCOORD1;
                    float4 interp2 : TEXCOORD2;
                    float4 interp3 : TEXCOORD3;
                    float4 interp4 : TEXCOORD4;
                    float3 interp5 : TEXCOORD5;
                    #if defined(LIGHTMAP_ON)
                    float2 interp6 : TEXCOORD6;
                    #endif
                    #if !defined(LIGHTMAP_ON)
                    float3 interp7 : TEXCOORD7;
                    #endif
                    float4 interp8 : TEXCOORD8;
                    float4 interp9 : TEXCOORD9;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
    
                PackedVaryings PackVaryings (Varyings input)
                {
                    PackedVaryings output;
                    output.positionCS = input.positionCS;
                    output.interp0.xyz =  input.positionWS;
                    output.interp1.xyz =  input.normalWS;
                    output.interp2.xyzw =  input.tangentWS;
                    output.interp3.xyzw =  input.texCoord0;
                    output.interp4.xyzw =  input.color;
                    output.interp5.xyz =  input.viewDirectionWS;
                    #if defined(LIGHTMAP_ON)
                    output.interp6.xy =  input.lightmapUV;
                    #endif
                    #if !defined(LIGHTMAP_ON)
                    output.interp7.xyz =  input.sh;
                    #endif
                    output.interp8.xyzw =  input.fogFactorAndVertexLight;
                    output.interp9.xyzw =  input.shadowCoord;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
                Varyings UnpackVaryings (PackedVaryings input)
                {
                    Varyings output;
                    output.positionCS = input.positionCS;
                    output.positionWS = input.interp0.xyz;
                    output.normalWS = input.interp1.xyz;
                    output.tangentWS = input.interp2.xyzw;
                    output.texCoord0 = input.interp3.xyzw;
                    output.color = input.interp4.xyzw;
                    output.viewDirectionWS = input.interp5.xyz;
                    #if defined(LIGHTMAP_ON)
                    output.lightmapUV = input.interp6.xy;
                    #endif
                    #if !defined(LIGHTMAP_ON)
                    output.sh = input.interp7.xyz;
                    #endif
                    output.fogFactorAndVertexLight = input.interp8.xyzw;
                    output.shadowCoord = input.interp9.xyzw;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _AlphaCutoff;
                float4 _BaseColor;
                float4 _BaseColorMap_TexelSize;
                float _BaseUsePlanarUV;
                float4 _BaseTilingOffset;
                float4 _BaseNormalMap_TexelSize;
                float _BaseNormalScale;
                float4 _BaseMaskMap_TexelSize;
                float _BaseMetallic;
                float _BaseAORemapMin;
                float _BaseAORemapMax;
                float _BaseSmoothnessRemapMin;
                float _BaseSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float _Invert_Layer_Mask;
                float _Height_Transition;
                float _HeightMin;
                float _HeightMax;
                float _HeightOffset;
                float _HeightMin2;
                float _HeightMax2;
                float _HeightOffset2;
                float4 _Base2Color;
                float4 _Base2ColorMap_TexelSize;
                float4 _Base2TilingOffset;
                float _Base2UsePlanarUV;
                float4 _Base2NormalMap_TexelSize;
                float _Base2NormalScale;
                float4 _Base2MaskMap_TexelSize;
                float _Base2Metallic;
                float _Base2SmoothnessRemapMin;
                float _Base2SmoothnessRemapMax;
                float _Base2AORemapMin;
                float _Base2AORemapMax;
                float4 _WetColor;
                float _WetSmoothness;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_BaseColorMap);
                SAMPLER(sampler_BaseColorMap);
                TEXTURE2D(_BaseNormalMap);
                SAMPLER(sampler_BaseNormalMap);
                TEXTURE2D(_BaseMaskMap);
                SAMPLER(sampler_BaseMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_Base2ColorMap);
                SAMPLER(sampler_Base2ColorMap);
                TEXTURE2D(_Base2NormalMap);
                SAMPLER(sampler_Base2NormalMap);
                TEXTURE2D(_Base2MaskMap);
                SAMPLER(sampler_Base2MaskMap);
                SAMPLER(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 6a9c7522090e0644e0cdf14d6feac267
                #include "Assets/NatureManufacture Assets/Object Shaders/NM_Object_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b
                {
                };
                
                void SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(float3 Vector3_314C8600, Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                {
                    Out = A * B;
                }
                
                void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                {
                    Out = UV * Tiling + Offset;
                }
                
                void Unity_Branch_float2(float Predicate, float2 True, float2 False, out float2 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                struct Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6
                {
                    float3 AbsoluteWorldSpacePosition;
                    half4 uv0;
                };
                
                void SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float4 Vector4_2EBA7A3B, float Boolean_7ABB9909, Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 IN, out float4 XZ_2)
                {
                    float _Property_30834f691775a0898a45b1c868520436_Out_0 = Boolean_7ABB9909;
                    float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
                    float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
                    float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
                    float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
                    float4 _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0 = Vector4_2EBA7A3B;
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[0];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[1];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[2];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[3];
                    float _Divide_e64179199923c58289b6aa94ea6c9178_Out_2;
                    Unity_Divide_float(1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Divide_e64179199923c58289b6aa94ea6c9178_Out_2);
                    float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
                    Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_e64179199923c58289b6aa94ea6c9178_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
                    float2 _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2);
                    float2 _Vector2_f8d75f54e7705083bbec539a60185577_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4);
                    float2 _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0, _Vector2_f8d75f54e7705083bbec539a60185577_Out_0, _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3);
                    float2 _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3;
                    Unity_Branch_float2(_Property_30834f691775a0898a45b1c868520436_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
                    float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
                    XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
                }
                
                void Unity_Add_float2(float2 A, float2 B, out float2 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
                {
                    Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
                }
                
                void Unity_OneMinus_float(float In, out float Out)
                {
                    Out = 1 - In;
                }
                
                void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Maximum_float(float A, float B, out float Out)
                {
                    Out = max(A, B);
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Add_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A / B;
                }
                
                struct Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135
                {
                };
                
                void SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(float3 Vector3_88EEBB5E, float Vector1_DA0A37FA, float3 Vector3_79AA92F, float Vector1_F7E83F1E, float Vector1_1C9222A6, Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 IN, out float3 OutVector4_1)
                {
                    float3 _Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0 = Vector3_88EEBB5E;
                    float _Property_14119cc7eaf4128f991283d47cf72d85_Out_0 = Vector1_DA0A37FA;
                    float _Property_48af0ad45e3f7f82932b938695d21391_Out_0 = Vector1_DA0A37FA;
                    float _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0 = Vector1_F7E83F1E;
                    float _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2;
                    Unity_Maximum_float(_Property_48af0ad45e3f7f82932b938695d21391_Out_0, _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0, _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2);
                    float _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0 = Vector1_1C9222A6;
                    float _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2;
                    Unity_Subtract_float(_Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2, _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2);
                    float _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2;
                    Unity_Subtract_float(_Property_14119cc7eaf4128f991283d47cf72d85_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2);
                    float _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2;
                    Unity_Maximum_float(_Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2, 0, _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2);
                    float3 _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2;
                    Unity_Multiply_float(_Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0, (_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2.xxx), _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2);
                    float3 _Property_c7292b3b08585f8c8670172b9a220bf0_Out_0 = Vector3_79AA92F;
                    float _Property_5e920479576fad83ba1947728dcceab4_Out_0 = Vector1_F7E83F1E;
                    float _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2;
                    Unity_Subtract_float(_Property_5e920479576fad83ba1947728dcceab4_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2);
                    float _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2;
                    Unity_Maximum_float(_Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2, 0, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2);
                    float3 _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2;
                    Unity_Multiply_float(_Property_c7292b3b08585f8c8670172b9a220bf0_Out_0, (_Maximum_216777d30802328eab607c8fe68ba3a1_Out_2.xxx), _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2);
                    float3 _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2;
                    Unity_Add_float3(_Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2, _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2, _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2);
                    float _Add_356384b52728f583bd6e694bc1fc3738_Out_2;
                    Unity_Add_float(_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2, _Add_356384b52728f583bd6e694bc1fc3738_Out_2);
                    float _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2;
                    Unity_Maximum_float(_Add_356384b52728f583bd6e694bc1fc3738_Out_2, 1E-05, _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2);
                    float3 _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
                    Unity_Divide_float3(_Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2, (_Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2.xxx), _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2);
                    OutVector4_1 = _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
                }
                
                void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
                {
                    Out = lerp(A, B, T);
                }
                
                void Unity_Sign_float3(float3 In, out float3 Out)
                {
                    Out = sign(In);
                }
                
                void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Normalize_float3(float3 In, out float3 Out)
                {
                    Out = normalize(In);
                }
                
                void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                struct Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8
                {
                    float3 WorldSpaceNormal;
                    float3 WorldSpaceTangent;
                    float3 WorldSpaceBiTangent;
                    float3 AbsoluteWorldSpacePosition;
                    half4 uv0;
                };
                
                void SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float4 Vector4_82674548, float Boolean_9FF42DF6, Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 IN, out float4 XZ_2)
                {
                    float _Property_1ef12cf3201a938993fe6a7951b0e754_Out_0 = Boolean_9FF42DF6;
                    float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
                    float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
                    float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
                    float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
                    float4 _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0 = Vector4_82674548;
                    float _Split_a2e12fa5931da084b2949343a539dfd8_R_1 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[0];
                    float _Split_a2e12fa5931da084b2949343a539dfd8_G_2 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[1];
                    float _Split_a2e12fa5931da084b2949343a539dfd8_B_3 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[2];
                    float _Split_a2e12fa5931da084b2949343a539dfd8_A_4 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[3];
                    float _Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2;
                    Unity_Divide_float(1, _Split_a2e12fa5931da084b2949343a539dfd8_R_1, _Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2);
                    float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
                    Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
                    float2 _Vector2_6845d21872714d889783b0cb707df3e9_Out_0 = float2(_Split_a2e12fa5931da084b2949343a539dfd8_R_1, _Split_a2e12fa5931da084b2949343a539dfd8_G_2);
                    float2 _Vector2_e2e2263627c6098e96a5b5d29350ad03_Out_0 = float2(_Split_a2e12fa5931da084b2949343a539dfd8_B_3, _Split_a2e12fa5931da084b2949343a539dfd8_A_4);
                    float2 _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_6845d21872714d889783b0cb707df3e9_Out_0, _Vector2_e2e2263627c6098e96a5b5d29350ad03_Out_0, _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3);
                    float2 _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3;
                    Unity_Branch_float2(_Property_1ef12cf3201a938993fe6a7951b0e754_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3, _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3);
                    float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3);
                    _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0);
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
                    float2 _Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0 = float2(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4, _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5);
                    float3 _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1;
                    Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1);
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_R_1 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[0];
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_G_2 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[1];
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_B_3 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[2];
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_A_4 = 0;
                    float2 _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0 = float2(_Split_6299d4ddcc4c74828aea40a46fdb896e_G_2, 1);
                    float2 _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2;
                    Unity_Multiply_float(_Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0, _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0, _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2);
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1 = IN.WorldSpaceNormal[0];
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2 = IN.WorldSpaceNormal[1];
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3 = IN.WorldSpaceNormal[2];
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_A_4 = 0;
                    float2 _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0 = float2(_Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1, _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3);
                    float2 _Add_1145b2f896593d80aa864a34e6702562_Out_2;
                    Unity_Add_float2(_Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2, _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0, _Add_1145b2f896593d80aa864a34e6702562_Out_2);
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_R_1 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[0];
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[1];
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_B_3 = 0;
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_A_4 = 0;
                    float _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6, _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2, _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2);
                    float3 _Vector3_433840b555db308b97e9b14b6a957195_Out_0 = float3(_Split_2bc77ca2d17bd78cb2383770ce50b179_R_1, _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2, _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2);
                    float3x3 Transform_c7914cc45a011c89b3f53c55afb51673_tangentTransform_World = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
                    float3 _Transform_c7914cc45a011c89b3f53c55afb51673_Out_1 = TransformWorldToTangent(_Vector3_433840b555db308b97e9b14b6a957195_Out_0.xyz, Transform_c7914cc45a011c89b3f53c55afb51673_tangentTransform_World);
                    float3 _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1;
                    Unity_Normalize_float3(_Transform_c7914cc45a011c89b3f53c55afb51673_Out_1, _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1);
                    float3 _Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3;
                    Unity_Branch_float3(_Property_1ef12cf3201a938993fe6a7951b0e754_Out_0, _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1, (_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.xyz), _Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3);
                    XZ_2 = (float4(_Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3, 1.0));
                }
                
                void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
                {
                    Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
                }
                
                void Unity_Lerp_float(float A, float B, float T, out float Out)
                {
                    Out = lerp(A, B, T);
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7;
                    float3 _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1;
                    SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7, _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1);
                    description.Position = _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float3 BaseColor;
                    float3 NormalTS;
                    float3 Emission;
                    float Metallic;
                    float Smoothness;
                    float Occlusion;
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    float4 _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0 = _BaseTilingOffset;
                    float _Property_7f998178363b4188ba2f07298ef869c1_Out_0 = _BaseUsePlanarUV;
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e;
                    _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.uv0 = IN.uv0;
                    float4 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2);
                    float4 _Property_b83097c58639858680bf43881a95b0af_Out_0 = _BaseColor;
                    float4 _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2;
                    Unity_Multiply_float(_PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2, _Property_b83097c58639858680bf43881a95b0af_Out_0, _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2);
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_4245c3b264047180b5c90a697d6cb278;
                    _PlanarNM_4245c3b264047180b5c90a697d6cb278.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_4245c3b264047180b5c90a697d6cb278.uv0 = IN.uv0;
                    float4 _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseMaskMap, sampler_BaseMaskMap), _BaseMaskMap_TexelSize, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_4245c3b264047180b5c90a697d6cb278, _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2);
                    float _Split_91a015dea8acd38b904ba0935328a5bc_R_1 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[0];
                    float _Split_91a015dea8acd38b904ba0935328a5bc_G_2 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[1];
                    float _Split_91a015dea8acd38b904ba0935328a5bc_B_3 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[2];
                    float _Split_91a015dea8acd38b904ba0935328a5bc_A_4 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[3];
                    float _Property_fbcff1469ebf488394a8a89ddaf0eb2a_Out_0 = _HeightMin;
                    float _Property_9df7a44c8225168683743ac60c0c3c34_Out_0 = _HeightMax;
                    float2 _Vector2_9b1e95888c28bc8893f28c02b87fa448_Out_0 = float2(_Property_fbcff1469ebf488394a8a89ddaf0eb2a_Out_0, _Property_9df7a44c8225168683743ac60c0c3c34_Out_0);
                    float _Property_29ca14fd0b712983a38d63d2dd326e96_Out_0 = _HeightOffset;
                    float2 _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2;
                    Unity_Add_float2(_Vector2_9b1e95888c28bc8893f28c02b87fa448_Out_0, (_Property_29ca14fd0b712983a38d63d2dd326e96_Out_0.xx), _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2);
                    float _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3;
                    Unity_Remap_float(_Split_91a015dea8acd38b904ba0935328a5bc_B_3, float2 (0, 1), _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3);
                    float4 _Property_86a4657df480d48e8d3ad3b036731380_Out_0 = _Base2TilingOffset;
                    float _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0 = _Base2UsePlanarUV;
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4;
                    _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.uv0 = IN.uv0;
                    float4 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_Base2ColorMap, sampler_Base2ColorMap), _Base2ColorMap_TexelSize, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2);
                    float4 _Property_3561b11b899bda8e855826445cf628aa_Out_0 = _Base2Color;
                    float4 _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2;
                    Unity_Multiply_float(_PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2, _Property_3561b11b899bda8e855826445cf628aa_Out_0, _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2);
                    float _Split_85f63081c1b7bc8c83d6bbf4ba6648c5_R_1 = IN.VertexColor[0];
                    float _Split_85f63081c1b7bc8c83d6bbf4ba6648c5_G_2 = IN.VertexColor[1];
                    float _Split_85f63081c1b7bc8c83d6bbf4ba6648c5_B_3 = IN.VertexColor[2];
                    float _Split_85f63081c1b7bc8c83d6bbf4ba6648c5_A_4 = IN.VertexColor[3];
                    float _Property_df2df7bb5cfc3381beee7ec454da7542_Out_0 = _Invert_Layer_Mask;
                    float4 _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0 = SAMPLE_TEXTURE2D(_LayerMask, sampler_LayerMask, IN.uv0.xy);
                    float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.r;
                    float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_G_5 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.g;
                    float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_B_6 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.b;
                    float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_A_7 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.a;
                    float _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1;
                    Unity_OneMinus_float(_SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1);
                    float _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3;
                    Unity_Branch_float(_Property_df2df7bb5cfc3381beee7ec454da7542_Out_0, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1, _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3);
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb;
                    _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.uv0 = IN.uv0;
                    float4 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_Base2MaskMap, sampler_Base2MaskMap), _Base2MaskMap_TexelSize, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2);
                    float _Split_83ec66b648ab6c84848b42686c256cd7_R_1 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[0];
                    float _Split_83ec66b648ab6c84848b42686c256cd7_G_2 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[1];
                    float _Split_83ec66b648ab6c84848b42686c256cd7_B_3 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[2];
                    float _Split_83ec66b648ab6c84848b42686c256cd7_A_4 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[3];
                    float _Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0 = _HeightMin2;
                    float _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0 = _HeightMax2;
                    float2 _Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0 = float2(_Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0, _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0);
                    float _Property_151ae2702b614585af2000f0a812960f_Out_0 = _HeightOffset2;
                    float2 _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2;
                    Unity_Add_float2(_Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0, (_Property_151ae2702b614585af2000f0a812960f_Out_0.xx), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2);
                    float _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3;
                    Unity_Remap_float(_Split_83ec66b648ab6c84848b42686c256cd7_B_3, float2 (0, 1), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3);
                    float _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2;
                    Unity_Multiply_float(_Branch_af0c5e511241ce8eae748ae487df50fa_Out_3, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2);
                    float _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2;
                    Unity_Multiply_float(_Split_85f63081c1b7bc8c83d6bbf4ba6648c5_B_3, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2);
                    float _Property_818c8af4b930138e81034c886614171d_Out_0 = _Height_Transition;
                    Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_7501025b3a60738a9a9d362e35a9ab48;
                    float3 _HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1;
                    SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135((_Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2.xyz), _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3, (_Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2.xyz), _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Property_818c8af4b930138e81034c886614171d_Out_0, _HeightBlend_7501025b3a60738a9a9d362e35a9ab48, _HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1);
                    float4 _Property_696647de24586381a15debb755f8f569_Out_0 = _WetColor;
                    float3 _Multiply_dec52e2895a185829e24dfeaeeba8184_Out_2;
                    Unity_Multiply_float((_Property_696647de24586381a15debb755f8f569_Out_0.xyz), _HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1, _Multiply_dec52e2895a185829e24dfeaeeba8184_Out_2);
                    float _OneMinus_0b9ce7d9f924bf8193dc9bdd9b2268e1_Out_1;
                    Unity_OneMinus_float(_Split_85f63081c1b7bc8c83d6bbf4ba6648c5_R_1, _OneMinus_0b9ce7d9f924bf8193dc9bdd9b2268e1_Out_1);
                    float3 _Lerp_7a7642d5ea869889935d4d1799cc7ad3_Out_3;
                    Unity_Lerp_float3(_HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1, _Multiply_dec52e2895a185829e24dfeaeeba8184_Out_2, (_OneMinus_0b9ce7d9f924bf8193dc9bdd9b2268e1_Out_1.xxx), _Lerp_7a7642d5ea869889935d4d1799cc7ad3_Out_3);
                    Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8;
                    _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceTangent = IN.WorldSpaceTangent;
                    _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                    _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.uv0 = IN.uv0;
                    float4 _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2;
                    SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_ARGS(_BaseNormalMap, sampler_BaseNormalMap), _BaseNormalMap_TexelSize, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8, _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2);
                    float _Property_d4b0759cf4647e81be065ec1465ce2b4_Out_0 = _BaseNormalScale;
                    float3 _NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2;
                    Unity_NormalStrength_float((_PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2.xyz), _Property_d4b0759cf4647e81be065ec1465ce2b4_Out_0, _NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2);
                    Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf;
                    _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceTangent = IN.WorldSpaceTangent;
                    _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                    _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.uv0 = IN.uv0;
                    float4 _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2;
                    SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_ARGS(_Base2NormalMap, sampler_Base2NormalMap), _Base2NormalMap_TexelSize, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf, _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2);
                    float _Property_8c31443b776727819a663c7ddce79064_Out_0 = _Base2NormalScale;
                    float3 _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2;
                    Unity_NormalStrength_float((_PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2.xyz), _Property_8c31443b776727819a663c7ddce79064_Out_0, _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2);
                    Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_7c09d97625efce898e21b66cd039be8b;
                    float3 _HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1;
                    SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(_NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3, _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Property_818c8af4b930138e81034c886614171d_Out_0, _HeightBlend_7c09d97625efce898e21b66cd039be8b, _HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1);
                    float _Property_afd0f3561038ef8487e614f350d364dd_Out_0 = _BaseMetallic;
                    float _Multiply_154e0f89b19c8e86926222afb13691e3_Out_2;
                    Unity_Multiply_float(_Split_91a015dea8acd38b904ba0935328a5bc_R_1, _Property_afd0f3561038ef8487e614f350d364dd_Out_0, _Multiply_154e0f89b19c8e86926222afb13691e3_Out_2);
                    float _Property_b82ce26778f44c8fa3510d1a8ed92d0d_Out_0 = _BaseAORemapMin;
                    float _Property_9d07c7a09a85da809f1d4661406e0888_Out_0 = _BaseAORemapMax;
                    float2 _Vector2_10162c774de2a7838426399cfe98be82_Out_0 = float2(_Property_b82ce26778f44c8fa3510d1a8ed92d0d_Out_0, _Property_9d07c7a09a85da809f1d4661406e0888_Out_0);
                    float _Remap_c45fda31db668c81a9e89e11297ec993_Out_3;
                    Unity_Remap_float(_Split_91a015dea8acd38b904ba0935328a5bc_G_2, float2 (0, 1), _Vector2_10162c774de2a7838426399cfe98be82_Out_0, _Remap_c45fda31db668c81a9e89e11297ec993_Out_3);
                    float _Property_04a7bb2753456b8293b3e46e346b646e_Out_0 = _BaseSmoothnessRemapMin;
                    float _Property_75c8631fc908bb8ba8542d2e70d18cbf_Out_0 = _BaseSmoothnessRemapMax;
                    float2 _Vector2_b2e1a3c487cdf88f9b5992b831ba24d6_Out_0 = float2(_Property_04a7bb2753456b8293b3e46e346b646e_Out_0, _Property_75c8631fc908bb8ba8542d2e70d18cbf_Out_0);
                    float _Remap_65ca5af95590f88da70777476b6efd40_Out_3;
                    Unity_Remap_float(_Split_91a015dea8acd38b904ba0935328a5bc_A_4, float2 (0, 1), _Vector2_b2e1a3c487cdf88f9b5992b831ba24d6_Out_0, _Remap_65ca5af95590f88da70777476b6efd40_Out_3);
                    float3 _Vector3_28c1e2dadb10138a9799d970043db9b0_Out_0 = float3(_Multiply_154e0f89b19c8e86926222afb13691e3_Out_2, _Remap_c45fda31db668c81a9e89e11297ec993_Out_3, _Remap_65ca5af95590f88da70777476b6efd40_Out_3);
                    float _Property_4ead43cc6d37b68eb268dd80c3a561e9_Out_0 = _Base2Metallic;
                    float _Multiply_eef7838a4634498b9cf12d1bee89d853_Out_2;
                    Unity_Multiply_float(_Split_83ec66b648ab6c84848b42686c256cd7_R_1, _Property_4ead43cc6d37b68eb268dd80c3a561e9_Out_0, _Multiply_eef7838a4634498b9cf12d1bee89d853_Out_2);
                    float _Property_e1ed9fe432388887abb17b07dcc5ca6b_Out_0 = _Base2AORemapMin;
                    float _Property_cb0cf7882dcbcf88989a12f73fb7c917_Out_0 = _Base2AORemapMax;
                    float2 _Vector2_2d74d82ae79d5681a097c2e3ce20c913_Out_0 = float2(_Property_e1ed9fe432388887abb17b07dcc5ca6b_Out_0, _Property_cb0cf7882dcbcf88989a12f73fb7c917_Out_0);
                    float _Remap_dcd2e2871e334281a15cdd1da6103c7f_Out_3;
                    Unity_Remap_float(_Split_83ec66b648ab6c84848b42686c256cd7_G_2, float2 (0, 1), _Vector2_2d74d82ae79d5681a097c2e3ce20c913_Out_0, _Remap_dcd2e2871e334281a15cdd1da6103c7f_Out_3);
                    float _Property_159cd47513de4f85a992da1f43f77c51_Out_0 = _Base2SmoothnessRemapMin;
                    float _Property_b1f3c7061cf84380b1a0ffc2c5f770db_Out_0 = _Base2SmoothnessRemapMax;
                    float2 _Vector2_eb0fcc98def54d83abe1cfec60457b78_Out_0 = float2(_Property_159cd47513de4f85a992da1f43f77c51_Out_0, _Property_b1f3c7061cf84380b1a0ffc2c5f770db_Out_0);
                    float _Remap_1214803bb0f7c387adc088fb938f7971_Out_3;
                    Unity_Remap_float(_Split_83ec66b648ab6c84848b42686c256cd7_A_4, float2 (0, 1), _Vector2_eb0fcc98def54d83abe1cfec60457b78_Out_0, _Remap_1214803bb0f7c387adc088fb938f7971_Out_3);
                    float3 _Vector3_ddb5452f73a0dc819b57dbe981a5f4e7_Out_0 = float3(_Multiply_eef7838a4634498b9cf12d1bee89d853_Out_2, _Remap_dcd2e2871e334281a15cdd1da6103c7f_Out_3, _Remap_1214803bb0f7c387adc088fb938f7971_Out_3);
                    Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_3ef23bc9c463ea8f91d2c1bc27c32dff;
                    float3 _HeightBlend_3ef23bc9c463ea8f91d2c1bc27c32dff_OutVector4_1;
                    SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(_Vector3_28c1e2dadb10138a9799d970043db9b0_Out_0, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3, _Vector3_ddb5452f73a0dc819b57dbe981a5f4e7_Out_0, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Property_818c8af4b930138e81034c886614171d_Out_0, _HeightBlend_3ef23bc9c463ea8f91d2c1bc27c32dff, _HeightBlend_3ef23bc9c463ea8f91d2c1bc27c32dff_OutVector4_1);
                    float _Split_93a6a2f8a95a1b80bea53b3c9628de7b_R_1 = _HeightBlend_3ef23bc9c463ea8f91d2c1bc27c32dff_OutVector4_1[0];
                    float _Split_93a6a2f8a95a1b80bea53b3c9628de7b_G_2 = _HeightBlend_3ef23bc9c463ea8f91d2c1bc27c32dff_OutVector4_1[1];
                    float _Split_93a6a2f8a95a1b80bea53b3c9628de7b_B_3 = _HeightBlend_3ef23bc9c463ea8f91d2c1bc27c32dff_OutVector4_1[2];
                    float _Split_93a6a2f8a95a1b80bea53b3c9628de7b_A_4 = 0;
                    float _Property_c517a33d4cfc53868e1596c4fe2fb681_Out_0 = _WetSmoothness;
                    float _Lerp_3c369133aa2f1781a71532efbad4b64d_Out_3;
                    Unity_Lerp_float(_Split_93a6a2f8a95a1b80bea53b3c9628de7b_B_3, _Property_c517a33d4cfc53868e1596c4fe2fb681_Out_0, _OneMinus_0b9ce7d9f924bf8193dc9bdd9b2268e1_Out_1, _Lerp_3c369133aa2f1781a71532efbad4b64d_Out_3);
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_R_1 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[0];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_G_2 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[1];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_B_3 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[2];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[3];
                    float _Property_8bc98dd454a5508b9864a6ba09772356_Out_0 = _AlphaCutoff;
                    surface.BaseColor = _Lerp_7a7642d5ea869889935d4d1799cc7ad3_Out_3;
                    surface.NormalTS = _HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1;
                    surface.Emission = float3(0, 0, 0);
                    surface.Metallic = _Split_93a6a2f8a95a1b80bea53b3c9628de7b_R_1;
                    surface.Smoothness = _Lerp_3c369133aa2f1781a71532efbad4b64d_Out_3;
                    surface.Occlusion = _Split_93a6a2f8a95a1b80bea53b3c9628de7b_G_2;
                    surface.Alpha = _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4;
                    surface.AlphaClipThreshold = _Property_8bc98dd454a5508b9864a6ba09772356_Out_0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.ObjectSpacePosition =         input.positionOS;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                	// must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
                	float3 unnormalizedNormalWS = input.normalWS;
                    const float renormFactor = 1.0 / length(unnormalizedNormalWS);
                
                	// use bitangent on the fly like in hdrp
                	// IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
                    float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
                	float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
                
                    output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
                    output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                
                	// to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
                	// This is explained in section 2.2 in "surface gradient based bump mapping framework"
                    output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
                	output.WorldSpaceBiTangent =         renormFactor*bitang;
                
                    output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
                    output.uv0 =                         input.texCoord0;
                    output.VertexColor =                 input.color;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRForwardPass.hlsl"
    
                ENDHLSL
            }
            Pass
            {
                Name "GBuffer"
                Tags
                {
                    "LightMode" = "UniversalGBuffer"
                }
    
                // Render State
                Cull Back
                Blend One Zero
                ZTest LEqual
                ZWrite On
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 4.5
                #pragma exclude_renderers gles gles3 glcore
                #pragma multi_compile_instancing
                #pragma multi_compile_fog
                #pragma multi_compile _ DOTS_INSTANCING_ON
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                #pragma multi_compile _ LIGHTMAP_ON
                #pragma multi_compile _ DIRLIGHTMAP_COMBINED
                #pragma multi_compile _ _MAIN_LIGHT_SHADOWS
                #pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
                #pragma multi_compile _ _SHADOWS_SOFT
                #pragma multi_compile _ _MIXED_LIGHTING_SUBTRACTIVE
                #pragma multi_compile _ _GBUFFER_NORMALS_OCT
                // GraphKeywords: <None>
    
                // Defines
                #define _AlphaClip 1
                #define _NORMALMAP 1
                #define _NORMAL_DROPOFF_TS 1
                #define ATTRIBUTES_NEED_NORMAL
                #define ATTRIBUTES_NEED_TANGENT
                #define ATTRIBUTES_NEED_TEXCOORD0
                #define ATTRIBUTES_NEED_TEXCOORD1
                #define ATTRIBUTES_NEED_COLOR
                #define VARYINGS_NEED_POSITION_WS
                #define VARYINGS_NEED_NORMAL_WS
                #define VARYINGS_NEED_TANGENT_WS
                #define VARYINGS_NEED_TEXCOORD0
                #define VARYINGS_NEED_COLOR
                #define VARYINGS_NEED_VIEWDIRECTION_WS
                #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_GBUFFER
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    float3 positionOS : POSITION;
                    float3 normalOS : NORMAL;
                    float4 tangentOS : TANGENT;
                    float4 uv0 : TEXCOORD0;
                    float4 uv1 : TEXCOORD1;
                    float4 color : COLOR;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                };
                struct Varyings
                {
                    float4 positionCS : SV_POSITION;
                    float3 positionWS;
                    float3 normalWS;
                    float4 tangentWS;
                    float4 texCoord0;
                    float4 color;
                    float3 viewDirectionWS;
                    #if defined(LIGHTMAP_ON)
                    float2 lightmapUV;
                    #endif
                    #if !defined(LIGHTMAP_ON)
                    float3 sh;
                    #endif
                    float4 fogFactorAndVertexLight;
                    float4 shadowCoord;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    float3 WorldSpaceNormal;
                    float3 TangentSpaceNormal;
                    float3 WorldSpaceTangent;
                    float3 WorldSpaceBiTangent;
                    float3 AbsoluteWorldSpacePosition;
                    float4 uv0;
                    float4 VertexColor;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 ObjectSpacePosition;
                };
                struct PackedVaryings
                {
                    float4 positionCS : SV_POSITION;
                    float3 interp0 : TEXCOORD0;
                    float3 interp1 : TEXCOORD1;
                    float4 interp2 : TEXCOORD2;
                    float4 interp3 : TEXCOORD3;
                    float4 interp4 : TEXCOORD4;
                    float3 interp5 : TEXCOORD5;
                    #if defined(LIGHTMAP_ON)
                    float2 interp6 : TEXCOORD6;
                    #endif
                    #if !defined(LIGHTMAP_ON)
                    float3 interp7 : TEXCOORD7;
                    #endif
                    float4 interp8 : TEXCOORD8;
                    float4 interp9 : TEXCOORD9;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
    
                PackedVaryings PackVaryings (Varyings input)
                {
                    PackedVaryings output;
                    output.positionCS = input.positionCS;
                    output.interp0.xyz =  input.positionWS;
                    output.interp1.xyz =  input.normalWS;
                    output.interp2.xyzw =  input.tangentWS;
                    output.interp3.xyzw =  input.texCoord0;
                    output.interp4.xyzw =  input.color;
                    output.interp5.xyz =  input.viewDirectionWS;
                    #if defined(LIGHTMAP_ON)
                    output.interp6.xy =  input.lightmapUV;
                    #endif
                    #if !defined(LIGHTMAP_ON)
                    output.interp7.xyz =  input.sh;
                    #endif
                    output.interp8.xyzw =  input.fogFactorAndVertexLight;
                    output.interp9.xyzw =  input.shadowCoord;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
                Varyings UnpackVaryings (PackedVaryings input)
                {
                    Varyings output;
                    output.positionCS = input.positionCS;
                    output.positionWS = input.interp0.xyz;
                    output.normalWS = input.interp1.xyz;
                    output.tangentWS = input.interp2.xyzw;
                    output.texCoord0 = input.interp3.xyzw;
                    output.color = input.interp4.xyzw;
                    output.viewDirectionWS = input.interp5.xyz;
                    #if defined(LIGHTMAP_ON)
                    output.lightmapUV = input.interp6.xy;
                    #endif
                    #if !defined(LIGHTMAP_ON)
                    output.sh = input.interp7.xyz;
                    #endif
                    output.fogFactorAndVertexLight = input.interp8.xyzw;
                    output.shadowCoord = input.interp9.xyzw;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _AlphaCutoff;
                float4 _BaseColor;
                float4 _BaseColorMap_TexelSize;
                float _BaseUsePlanarUV;
                float4 _BaseTilingOffset;
                float4 _BaseNormalMap_TexelSize;
                float _BaseNormalScale;
                float4 _BaseMaskMap_TexelSize;
                float _BaseMetallic;
                float _BaseAORemapMin;
                float _BaseAORemapMax;
                float _BaseSmoothnessRemapMin;
                float _BaseSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float _Invert_Layer_Mask;
                float _Height_Transition;
                float _HeightMin;
                float _HeightMax;
                float _HeightOffset;
                float _HeightMin2;
                float _HeightMax2;
                float _HeightOffset2;
                float4 _Base2Color;
                float4 _Base2ColorMap_TexelSize;
                float4 _Base2TilingOffset;
                float _Base2UsePlanarUV;
                float4 _Base2NormalMap_TexelSize;
                float _Base2NormalScale;
                float4 _Base2MaskMap_TexelSize;
                float _Base2Metallic;
                float _Base2SmoothnessRemapMin;
                float _Base2SmoothnessRemapMax;
                float _Base2AORemapMin;
                float _Base2AORemapMax;
                float4 _WetColor;
                float _WetSmoothness;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_BaseColorMap);
                SAMPLER(sampler_BaseColorMap);
                TEXTURE2D(_BaseNormalMap);
                SAMPLER(sampler_BaseNormalMap);
                TEXTURE2D(_BaseMaskMap);
                SAMPLER(sampler_BaseMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_Base2ColorMap);
                SAMPLER(sampler_Base2ColorMap);
                TEXTURE2D(_Base2NormalMap);
                SAMPLER(sampler_Base2NormalMap);
                TEXTURE2D(_Base2MaskMap);
                SAMPLER(sampler_Base2MaskMap);
                SAMPLER(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 6a9c7522090e0644e0cdf14d6feac267
                #include "Assets/NatureManufacture Assets/Object Shaders/NM_Object_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b
                {
                };
                
                void SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(float3 Vector3_314C8600, Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                {
                    Out = A * B;
                }
                
                void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                {
                    Out = UV * Tiling + Offset;
                }
                
                void Unity_Branch_float2(float Predicate, float2 True, float2 False, out float2 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                struct Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6
                {
                    float3 AbsoluteWorldSpacePosition;
                    half4 uv0;
                };
                
                void SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float4 Vector4_2EBA7A3B, float Boolean_7ABB9909, Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 IN, out float4 XZ_2)
                {
                    float _Property_30834f691775a0898a45b1c868520436_Out_0 = Boolean_7ABB9909;
                    float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
                    float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
                    float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
                    float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
                    float4 _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0 = Vector4_2EBA7A3B;
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[0];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[1];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[2];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[3];
                    float _Divide_e64179199923c58289b6aa94ea6c9178_Out_2;
                    Unity_Divide_float(1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Divide_e64179199923c58289b6aa94ea6c9178_Out_2);
                    float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
                    Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_e64179199923c58289b6aa94ea6c9178_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
                    float2 _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2);
                    float2 _Vector2_f8d75f54e7705083bbec539a60185577_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4);
                    float2 _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0, _Vector2_f8d75f54e7705083bbec539a60185577_Out_0, _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3);
                    float2 _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3;
                    Unity_Branch_float2(_Property_30834f691775a0898a45b1c868520436_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
                    float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
                    XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
                }
                
                void Unity_Add_float2(float2 A, float2 B, out float2 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
                {
                    Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
                }
                
                void Unity_OneMinus_float(float In, out float Out)
                {
                    Out = 1 - In;
                }
                
                void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Maximum_float(float A, float B, out float Out)
                {
                    Out = max(A, B);
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Add_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A / B;
                }
                
                struct Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135
                {
                };
                
                void SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(float3 Vector3_88EEBB5E, float Vector1_DA0A37FA, float3 Vector3_79AA92F, float Vector1_F7E83F1E, float Vector1_1C9222A6, Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 IN, out float3 OutVector4_1)
                {
                    float3 _Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0 = Vector3_88EEBB5E;
                    float _Property_14119cc7eaf4128f991283d47cf72d85_Out_0 = Vector1_DA0A37FA;
                    float _Property_48af0ad45e3f7f82932b938695d21391_Out_0 = Vector1_DA0A37FA;
                    float _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0 = Vector1_F7E83F1E;
                    float _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2;
                    Unity_Maximum_float(_Property_48af0ad45e3f7f82932b938695d21391_Out_0, _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0, _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2);
                    float _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0 = Vector1_1C9222A6;
                    float _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2;
                    Unity_Subtract_float(_Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2, _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2);
                    float _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2;
                    Unity_Subtract_float(_Property_14119cc7eaf4128f991283d47cf72d85_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2);
                    float _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2;
                    Unity_Maximum_float(_Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2, 0, _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2);
                    float3 _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2;
                    Unity_Multiply_float(_Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0, (_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2.xxx), _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2);
                    float3 _Property_c7292b3b08585f8c8670172b9a220bf0_Out_0 = Vector3_79AA92F;
                    float _Property_5e920479576fad83ba1947728dcceab4_Out_0 = Vector1_F7E83F1E;
                    float _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2;
                    Unity_Subtract_float(_Property_5e920479576fad83ba1947728dcceab4_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2);
                    float _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2;
                    Unity_Maximum_float(_Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2, 0, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2);
                    float3 _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2;
                    Unity_Multiply_float(_Property_c7292b3b08585f8c8670172b9a220bf0_Out_0, (_Maximum_216777d30802328eab607c8fe68ba3a1_Out_2.xxx), _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2);
                    float3 _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2;
                    Unity_Add_float3(_Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2, _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2, _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2);
                    float _Add_356384b52728f583bd6e694bc1fc3738_Out_2;
                    Unity_Add_float(_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2, _Add_356384b52728f583bd6e694bc1fc3738_Out_2);
                    float _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2;
                    Unity_Maximum_float(_Add_356384b52728f583bd6e694bc1fc3738_Out_2, 1E-05, _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2);
                    float3 _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
                    Unity_Divide_float3(_Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2, (_Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2.xxx), _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2);
                    OutVector4_1 = _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
                }
                
                void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
                {
                    Out = lerp(A, B, T);
                }
                
                void Unity_Sign_float3(float3 In, out float3 Out)
                {
                    Out = sign(In);
                }
                
                void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Normalize_float3(float3 In, out float3 Out)
                {
                    Out = normalize(In);
                }
                
                void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                struct Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8
                {
                    float3 WorldSpaceNormal;
                    float3 WorldSpaceTangent;
                    float3 WorldSpaceBiTangent;
                    float3 AbsoluteWorldSpacePosition;
                    half4 uv0;
                };
                
                void SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float4 Vector4_82674548, float Boolean_9FF42DF6, Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 IN, out float4 XZ_2)
                {
                    float _Property_1ef12cf3201a938993fe6a7951b0e754_Out_0 = Boolean_9FF42DF6;
                    float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
                    float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
                    float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
                    float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
                    float4 _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0 = Vector4_82674548;
                    float _Split_a2e12fa5931da084b2949343a539dfd8_R_1 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[0];
                    float _Split_a2e12fa5931da084b2949343a539dfd8_G_2 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[1];
                    float _Split_a2e12fa5931da084b2949343a539dfd8_B_3 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[2];
                    float _Split_a2e12fa5931da084b2949343a539dfd8_A_4 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[3];
                    float _Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2;
                    Unity_Divide_float(1, _Split_a2e12fa5931da084b2949343a539dfd8_R_1, _Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2);
                    float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
                    Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
                    float2 _Vector2_6845d21872714d889783b0cb707df3e9_Out_0 = float2(_Split_a2e12fa5931da084b2949343a539dfd8_R_1, _Split_a2e12fa5931da084b2949343a539dfd8_G_2);
                    float2 _Vector2_e2e2263627c6098e96a5b5d29350ad03_Out_0 = float2(_Split_a2e12fa5931da084b2949343a539dfd8_B_3, _Split_a2e12fa5931da084b2949343a539dfd8_A_4);
                    float2 _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_6845d21872714d889783b0cb707df3e9_Out_0, _Vector2_e2e2263627c6098e96a5b5d29350ad03_Out_0, _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3);
                    float2 _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3;
                    Unity_Branch_float2(_Property_1ef12cf3201a938993fe6a7951b0e754_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3, _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3);
                    float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3);
                    _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0);
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
                    float2 _Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0 = float2(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4, _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5);
                    float3 _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1;
                    Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1);
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_R_1 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[0];
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_G_2 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[1];
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_B_3 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[2];
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_A_4 = 0;
                    float2 _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0 = float2(_Split_6299d4ddcc4c74828aea40a46fdb896e_G_2, 1);
                    float2 _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2;
                    Unity_Multiply_float(_Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0, _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0, _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2);
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1 = IN.WorldSpaceNormal[0];
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2 = IN.WorldSpaceNormal[1];
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3 = IN.WorldSpaceNormal[2];
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_A_4 = 0;
                    float2 _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0 = float2(_Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1, _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3);
                    float2 _Add_1145b2f896593d80aa864a34e6702562_Out_2;
                    Unity_Add_float2(_Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2, _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0, _Add_1145b2f896593d80aa864a34e6702562_Out_2);
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_R_1 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[0];
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[1];
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_B_3 = 0;
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_A_4 = 0;
                    float _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6, _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2, _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2);
                    float3 _Vector3_433840b555db308b97e9b14b6a957195_Out_0 = float3(_Split_2bc77ca2d17bd78cb2383770ce50b179_R_1, _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2, _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2);
                    float3x3 Transform_c7914cc45a011c89b3f53c55afb51673_tangentTransform_World = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
                    float3 _Transform_c7914cc45a011c89b3f53c55afb51673_Out_1 = TransformWorldToTangent(_Vector3_433840b555db308b97e9b14b6a957195_Out_0.xyz, Transform_c7914cc45a011c89b3f53c55afb51673_tangentTransform_World);
                    float3 _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1;
                    Unity_Normalize_float3(_Transform_c7914cc45a011c89b3f53c55afb51673_Out_1, _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1);
                    float3 _Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3;
                    Unity_Branch_float3(_Property_1ef12cf3201a938993fe6a7951b0e754_Out_0, _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1, (_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.xyz), _Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3);
                    XZ_2 = (float4(_Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3, 1.0));
                }
                
                void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
                {
                    Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
                }
                
                void Unity_Lerp_float(float A, float B, float T, out float Out)
                {
                    Out = lerp(A, B, T);
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7;
                    float3 _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1;
                    SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7, _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1);
                    description.Position = _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float3 BaseColor;
                    float3 NormalTS;
                    float3 Emission;
                    float Metallic;
                    float Smoothness;
                    float Occlusion;
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    float4 _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0 = _BaseTilingOffset;
                    float _Property_7f998178363b4188ba2f07298ef869c1_Out_0 = _BaseUsePlanarUV;
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e;
                    _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.uv0 = IN.uv0;
                    float4 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2);
                    float4 _Property_b83097c58639858680bf43881a95b0af_Out_0 = _BaseColor;
                    float4 _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2;
                    Unity_Multiply_float(_PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2, _Property_b83097c58639858680bf43881a95b0af_Out_0, _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2);
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_4245c3b264047180b5c90a697d6cb278;
                    _PlanarNM_4245c3b264047180b5c90a697d6cb278.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_4245c3b264047180b5c90a697d6cb278.uv0 = IN.uv0;
                    float4 _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseMaskMap, sampler_BaseMaskMap), _BaseMaskMap_TexelSize, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_4245c3b264047180b5c90a697d6cb278, _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2);
                    float _Split_91a015dea8acd38b904ba0935328a5bc_R_1 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[0];
                    float _Split_91a015dea8acd38b904ba0935328a5bc_G_2 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[1];
                    float _Split_91a015dea8acd38b904ba0935328a5bc_B_3 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[2];
                    float _Split_91a015dea8acd38b904ba0935328a5bc_A_4 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[3];
                    float _Property_fbcff1469ebf488394a8a89ddaf0eb2a_Out_0 = _HeightMin;
                    float _Property_9df7a44c8225168683743ac60c0c3c34_Out_0 = _HeightMax;
                    float2 _Vector2_9b1e95888c28bc8893f28c02b87fa448_Out_0 = float2(_Property_fbcff1469ebf488394a8a89ddaf0eb2a_Out_0, _Property_9df7a44c8225168683743ac60c0c3c34_Out_0);
                    float _Property_29ca14fd0b712983a38d63d2dd326e96_Out_0 = _HeightOffset;
                    float2 _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2;
                    Unity_Add_float2(_Vector2_9b1e95888c28bc8893f28c02b87fa448_Out_0, (_Property_29ca14fd0b712983a38d63d2dd326e96_Out_0.xx), _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2);
                    float _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3;
                    Unity_Remap_float(_Split_91a015dea8acd38b904ba0935328a5bc_B_3, float2 (0, 1), _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3);
                    float4 _Property_86a4657df480d48e8d3ad3b036731380_Out_0 = _Base2TilingOffset;
                    float _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0 = _Base2UsePlanarUV;
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4;
                    _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.uv0 = IN.uv0;
                    float4 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_Base2ColorMap, sampler_Base2ColorMap), _Base2ColorMap_TexelSize, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2);
                    float4 _Property_3561b11b899bda8e855826445cf628aa_Out_0 = _Base2Color;
                    float4 _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2;
                    Unity_Multiply_float(_PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2, _Property_3561b11b899bda8e855826445cf628aa_Out_0, _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2);
                    float _Split_85f63081c1b7bc8c83d6bbf4ba6648c5_R_1 = IN.VertexColor[0];
                    float _Split_85f63081c1b7bc8c83d6bbf4ba6648c5_G_2 = IN.VertexColor[1];
                    float _Split_85f63081c1b7bc8c83d6bbf4ba6648c5_B_3 = IN.VertexColor[2];
                    float _Split_85f63081c1b7bc8c83d6bbf4ba6648c5_A_4 = IN.VertexColor[3];
                    float _Property_df2df7bb5cfc3381beee7ec454da7542_Out_0 = _Invert_Layer_Mask;
                    float4 _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0 = SAMPLE_TEXTURE2D(_LayerMask, sampler_LayerMask, IN.uv0.xy);
                    float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.r;
                    float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_G_5 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.g;
                    float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_B_6 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.b;
                    float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_A_7 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.a;
                    float _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1;
                    Unity_OneMinus_float(_SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1);
                    float _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3;
                    Unity_Branch_float(_Property_df2df7bb5cfc3381beee7ec454da7542_Out_0, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1, _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3);
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb;
                    _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.uv0 = IN.uv0;
                    float4 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_Base2MaskMap, sampler_Base2MaskMap), _Base2MaskMap_TexelSize, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2);
                    float _Split_83ec66b648ab6c84848b42686c256cd7_R_1 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[0];
                    float _Split_83ec66b648ab6c84848b42686c256cd7_G_2 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[1];
                    float _Split_83ec66b648ab6c84848b42686c256cd7_B_3 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[2];
                    float _Split_83ec66b648ab6c84848b42686c256cd7_A_4 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[3];
                    float _Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0 = _HeightMin2;
                    float _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0 = _HeightMax2;
                    float2 _Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0 = float2(_Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0, _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0);
                    float _Property_151ae2702b614585af2000f0a812960f_Out_0 = _HeightOffset2;
                    float2 _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2;
                    Unity_Add_float2(_Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0, (_Property_151ae2702b614585af2000f0a812960f_Out_0.xx), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2);
                    float _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3;
                    Unity_Remap_float(_Split_83ec66b648ab6c84848b42686c256cd7_B_3, float2 (0, 1), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3);
                    float _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2;
                    Unity_Multiply_float(_Branch_af0c5e511241ce8eae748ae487df50fa_Out_3, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2);
                    float _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2;
                    Unity_Multiply_float(_Split_85f63081c1b7bc8c83d6bbf4ba6648c5_B_3, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2);
                    float _Property_818c8af4b930138e81034c886614171d_Out_0 = _Height_Transition;
                    Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_7501025b3a60738a9a9d362e35a9ab48;
                    float3 _HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1;
                    SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135((_Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2.xyz), _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3, (_Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2.xyz), _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Property_818c8af4b930138e81034c886614171d_Out_0, _HeightBlend_7501025b3a60738a9a9d362e35a9ab48, _HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1);
                    float4 _Property_696647de24586381a15debb755f8f569_Out_0 = _WetColor;
                    float3 _Multiply_dec52e2895a185829e24dfeaeeba8184_Out_2;
                    Unity_Multiply_float((_Property_696647de24586381a15debb755f8f569_Out_0.xyz), _HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1, _Multiply_dec52e2895a185829e24dfeaeeba8184_Out_2);
                    float _OneMinus_0b9ce7d9f924bf8193dc9bdd9b2268e1_Out_1;
                    Unity_OneMinus_float(_Split_85f63081c1b7bc8c83d6bbf4ba6648c5_R_1, _OneMinus_0b9ce7d9f924bf8193dc9bdd9b2268e1_Out_1);
                    float3 _Lerp_7a7642d5ea869889935d4d1799cc7ad3_Out_3;
                    Unity_Lerp_float3(_HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1, _Multiply_dec52e2895a185829e24dfeaeeba8184_Out_2, (_OneMinus_0b9ce7d9f924bf8193dc9bdd9b2268e1_Out_1.xxx), _Lerp_7a7642d5ea869889935d4d1799cc7ad3_Out_3);
                    Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8;
                    _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceTangent = IN.WorldSpaceTangent;
                    _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                    _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.uv0 = IN.uv0;
                    float4 _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2;
                    SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_ARGS(_BaseNormalMap, sampler_BaseNormalMap), _BaseNormalMap_TexelSize, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8, _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2);
                    float _Property_d4b0759cf4647e81be065ec1465ce2b4_Out_0 = _BaseNormalScale;
                    float3 _NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2;
                    Unity_NormalStrength_float((_PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2.xyz), _Property_d4b0759cf4647e81be065ec1465ce2b4_Out_0, _NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2);
                    Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf;
                    _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceTangent = IN.WorldSpaceTangent;
                    _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                    _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.uv0 = IN.uv0;
                    float4 _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2;
                    SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_ARGS(_Base2NormalMap, sampler_Base2NormalMap), _Base2NormalMap_TexelSize, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf, _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2);
                    float _Property_8c31443b776727819a663c7ddce79064_Out_0 = _Base2NormalScale;
                    float3 _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2;
                    Unity_NormalStrength_float((_PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2.xyz), _Property_8c31443b776727819a663c7ddce79064_Out_0, _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2);
                    Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_7c09d97625efce898e21b66cd039be8b;
                    float3 _HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1;
                    SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(_NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3, _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Property_818c8af4b930138e81034c886614171d_Out_0, _HeightBlend_7c09d97625efce898e21b66cd039be8b, _HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1);
                    float _Property_afd0f3561038ef8487e614f350d364dd_Out_0 = _BaseMetallic;
                    float _Multiply_154e0f89b19c8e86926222afb13691e3_Out_2;
                    Unity_Multiply_float(_Split_91a015dea8acd38b904ba0935328a5bc_R_1, _Property_afd0f3561038ef8487e614f350d364dd_Out_0, _Multiply_154e0f89b19c8e86926222afb13691e3_Out_2);
                    float _Property_b82ce26778f44c8fa3510d1a8ed92d0d_Out_0 = _BaseAORemapMin;
                    float _Property_9d07c7a09a85da809f1d4661406e0888_Out_0 = _BaseAORemapMax;
                    float2 _Vector2_10162c774de2a7838426399cfe98be82_Out_0 = float2(_Property_b82ce26778f44c8fa3510d1a8ed92d0d_Out_0, _Property_9d07c7a09a85da809f1d4661406e0888_Out_0);
                    float _Remap_c45fda31db668c81a9e89e11297ec993_Out_3;
                    Unity_Remap_float(_Split_91a015dea8acd38b904ba0935328a5bc_G_2, float2 (0, 1), _Vector2_10162c774de2a7838426399cfe98be82_Out_0, _Remap_c45fda31db668c81a9e89e11297ec993_Out_3);
                    float _Property_04a7bb2753456b8293b3e46e346b646e_Out_0 = _BaseSmoothnessRemapMin;
                    float _Property_75c8631fc908bb8ba8542d2e70d18cbf_Out_0 = _BaseSmoothnessRemapMax;
                    float2 _Vector2_b2e1a3c487cdf88f9b5992b831ba24d6_Out_0 = float2(_Property_04a7bb2753456b8293b3e46e346b646e_Out_0, _Property_75c8631fc908bb8ba8542d2e70d18cbf_Out_0);
                    float _Remap_65ca5af95590f88da70777476b6efd40_Out_3;
                    Unity_Remap_float(_Split_91a015dea8acd38b904ba0935328a5bc_A_4, float2 (0, 1), _Vector2_b2e1a3c487cdf88f9b5992b831ba24d6_Out_0, _Remap_65ca5af95590f88da70777476b6efd40_Out_3);
                    float3 _Vector3_28c1e2dadb10138a9799d970043db9b0_Out_0 = float3(_Multiply_154e0f89b19c8e86926222afb13691e3_Out_2, _Remap_c45fda31db668c81a9e89e11297ec993_Out_3, _Remap_65ca5af95590f88da70777476b6efd40_Out_3);
                    float _Property_4ead43cc6d37b68eb268dd80c3a561e9_Out_0 = _Base2Metallic;
                    float _Multiply_eef7838a4634498b9cf12d1bee89d853_Out_2;
                    Unity_Multiply_float(_Split_83ec66b648ab6c84848b42686c256cd7_R_1, _Property_4ead43cc6d37b68eb268dd80c3a561e9_Out_0, _Multiply_eef7838a4634498b9cf12d1bee89d853_Out_2);
                    float _Property_e1ed9fe432388887abb17b07dcc5ca6b_Out_0 = _Base2AORemapMin;
                    float _Property_cb0cf7882dcbcf88989a12f73fb7c917_Out_0 = _Base2AORemapMax;
                    float2 _Vector2_2d74d82ae79d5681a097c2e3ce20c913_Out_0 = float2(_Property_e1ed9fe432388887abb17b07dcc5ca6b_Out_0, _Property_cb0cf7882dcbcf88989a12f73fb7c917_Out_0);
                    float _Remap_dcd2e2871e334281a15cdd1da6103c7f_Out_3;
                    Unity_Remap_float(_Split_83ec66b648ab6c84848b42686c256cd7_G_2, float2 (0, 1), _Vector2_2d74d82ae79d5681a097c2e3ce20c913_Out_0, _Remap_dcd2e2871e334281a15cdd1da6103c7f_Out_3);
                    float _Property_159cd47513de4f85a992da1f43f77c51_Out_0 = _Base2SmoothnessRemapMin;
                    float _Property_b1f3c7061cf84380b1a0ffc2c5f770db_Out_0 = _Base2SmoothnessRemapMax;
                    float2 _Vector2_eb0fcc98def54d83abe1cfec60457b78_Out_0 = float2(_Property_159cd47513de4f85a992da1f43f77c51_Out_0, _Property_b1f3c7061cf84380b1a0ffc2c5f770db_Out_0);
                    float _Remap_1214803bb0f7c387adc088fb938f7971_Out_3;
                    Unity_Remap_float(_Split_83ec66b648ab6c84848b42686c256cd7_A_4, float2 (0, 1), _Vector2_eb0fcc98def54d83abe1cfec60457b78_Out_0, _Remap_1214803bb0f7c387adc088fb938f7971_Out_3);
                    float3 _Vector3_ddb5452f73a0dc819b57dbe981a5f4e7_Out_0 = float3(_Multiply_eef7838a4634498b9cf12d1bee89d853_Out_2, _Remap_dcd2e2871e334281a15cdd1da6103c7f_Out_3, _Remap_1214803bb0f7c387adc088fb938f7971_Out_3);
                    Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_3ef23bc9c463ea8f91d2c1bc27c32dff;
                    float3 _HeightBlend_3ef23bc9c463ea8f91d2c1bc27c32dff_OutVector4_1;
                    SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(_Vector3_28c1e2dadb10138a9799d970043db9b0_Out_0, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3, _Vector3_ddb5452f73a0dc819b57dbe981a5f4e7_Out_0, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Property_818c8af4b930138e81034c886614171d_Out_0, _HeightBlend_3ef23bc9c463ea8f91d2c1bc27c32dff, _HeightBlend_3ef23bc9c463ea8f91d2c1bc27c32dff_OutVector4_1);
                    float _Split_93a6a2f8a95a1b80bea53b3c9628de7b_R_1 = _HeightBlend_3ef23bc9c463ea8f91d2c1bc27c32dff_OutVector4_1[0];
                    float _Split_93a6a2f8a95a1b80bea53b3c9628de7b_G_2 = _HeightBlend_3ef23bc9c463ea8f91d2c1bc27c32dff_OutVector4_1[1];
                    float _Split_93a6a2f8a95a1b80bea53b3c9628de7b_B_3 = _HeightBlend_3ef23bc9c463ea8f91d2c1bc27c32dff_OutVector4_1[2];
                    float _Split_93a6a2f8a95a1b80bea53b3c9628de7b_A_4 = 0;
                    float _Property_c517a33d4cfc53868e1596c4fe2fb681_Out_0 = _WetSmoothness;
                    float _Lerp_3c369133aa2f1781a71532efbad4b64d_Out_3;
                    Unity_Lerp_float(_Split_93a6a2f8a95a1b80bea53b3c9628de7b_B_3, _Property_c517a33d4cfc53868e1596c4fe2fb681_Out_0, _OneMinus_0b9ce7d9f924bf8193dc9bdd9b2268e1_Out_1, _Lerp_3c369133aa2f1781a71532efbad4b64d_Out_3);
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_R_1 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[0];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_G_2 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[1];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_B_3 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[2];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[3];
                    float _Property_8bc98dd454a5508b9864a6ba09772356_Out_0 = _AlphaCutoff;
                    surface.BaseColor = _Lerp_7a7642d5ea869889935d4d1799cc7ad3_Out_3;
                    surface.NormalTS = _HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1;
                    surface.Emission = float3(0, 0, 0);
                    surface.Metallic = _Split_93a6a2f8a95a1b80bea53b3c9628de7b_R_1;
                    surface.Smoothness = _Lerp_3c369133aa2f1781a71532efbad4b64d_Out_3;
                    surface.Occlusion = _Split_93a6a2f8a95a1b80bea53b3c9628de7b_G_2;
                    surface.Alpha = _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4;
                    surface.AlphaClipThreshold = _Property_8bc98dd454a5508b9864a6ba09772356_Out_0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.ObjectSpacePosition =         input.positionOS;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                	// must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
                	float3 unnormalizedNormalWS = input.normalWS;
                    const float renormFactor = 1.0 / length(unnormalizedNormalWS);
                
                	// use bitangent on the fly like in hdrp
                	// IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
                    float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
                	float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
                
                    output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
                    output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                
                	// to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
                	// This is explained in section 2.2 in "surface gradient based bump mapping framework"
                    output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
                	output.WorldSpaceBiTangent =         renormFactor*bitang;
                
                    output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
                    output.uv0 =                         input.texCoord0;
                    output.VertexColor =                 input.color;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/UnityGBuffer.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRGBufferPass.hlsl"
    
                ENDHLSL
            }
            Pass
            {
                Name "ShadowCaster"
                Tags
                {
                    "LightMode" = "ShadowCaster"
                }
    
                // Render State
                Cull Back
                Blend One Zero
                ZTest LEqual
                ZWrite On
                ColorMask 0
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 4.5
                #pragma exclude_renderers gles gles3 glcore
                #pragma multi_compile_instancing
                #pragma multi_compile _ DOTS_INSTANCING_ON
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                // PassKeywords: <None>
                // GraphKeywords: <None>
    
                // Defines
                #define _AlphaClip 1
                #define _NORMALMAP 1
                #define _NORMAL_DROPOFF_TS 1
                #define ATTRIBUTES_NEED_NORMAL
                #define ATTRIBUTES_NEED_TANGENT
                #define ATTRIBUTES_NEED_TEXCOORD0
                #define VARYINGS_NEED_POSITION_WS
                #define VARYINGS_NEED_TEXCOORD0
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_SHADOWCASTER
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    float3 positionOS : POSITION;
                    float3 normalOS : NORMAL;
                    float4 tangentOS : TANGENT;
                    float4 uv0 : TEXCOORD0;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                };
                struct Varyings
                {
                    float4 positionCS : SV_POSITION;
                    float3 positionWS;
                    float4 texCoord0;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    float3 AbsoluteWorldSpacePosition;
                    float4 uv0;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 ObjectSpacePosition;
                };
                struct PackedVaryings
                {
                    float4 positionCS : SV_POSITION;
                    float3 interp0 : TEXCOORD0;
                    float4 interp1 : TEXCOORD1;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
    
                PackedVaryings PackVaryings (Varyings input)
                {
                    PackedVaryings output;
                    output.positionCS = input.positionCS;
                    output.interp0.xyz =  input.positionWS;
                    output.interp1.xyzw =  input.texCoord0;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
                Varyings UnpackVaryings (PackedVaryings input)
                {
                    Varyings output;
                    output.positionCS = input.positionCS;
                    output.positionWS = input.interp0.xyz;
                    output.texCoord0 = input.interp1.xyzw;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _AlphaCutoff;
                float4 _BaseColor;
                float4 _BaseColorMap_TexelSize;
                float _BaseUsePlanarUV;
                float4 _BaseTilingOffset;
                float4 _BaseNormalMap_TexelSize;
                float _BaseNormalScale;
                float4 _BaseMaskMap_TexelSize;
                float _BaseMetallic;
                float _BaseAORemapMin;
                float _BaseAORemapMax;
                float _BaseSmoothnessRemapMin;
                float _BaseSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float _Invert_Layer_Mask;
                float _Height_Transition;
                float _HeightMin;
                float _HeightMax;
                float _HeightOffset;
                float _HeightMin2;
                float _HeightMax2;
                float _HeightOffset2;
                float4 _Base2Color;
                float4 _Base2ColorMap_TexelSize;
                float4 _Base2TilingOffset;
                float _Base2UsePlanarUV;
                float4 _Base2NormalMap_TexelSize;
                float _Base2NormalScale;
                float4 _Base2MaskMap_TexelSize;
                float _Base2Metallic;
                float _Base2SmoothnessRemapMin;
                float _Base2SmoothnessRemapMax;
                float _Base2AORemapMin;
                float _Base2AORemapMax;
                float4 _WetColor;
                float _WetSmoothness;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_BaseColorMap);
                SAMPLER(sampler_BaseColorMap);
                TEXTURE2D(_BaseNormalMap);
                SAMPLER(sampler_BaseNormalMap);
                TEXTURE2D(_BaseMaskMap);
                SAMPLER(sampler_BaseMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_Base2ColorMap);
                SAMPLER(sampler_Base2ColorMap);
                TEXTURE2D(_Base2NormalMap);
                SAMPLER(sampler_Base2NormalMap);
                TEXTURE2D(_Base2MaskMap);
                SAMPLER(sampler_Base2MaskMap);
                SAMPLER(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 6a9c7522090e0644e0cdf14d6feac267
                #include "Assets/NatureManufacture Assets/Object Shaders/NM_Object_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b
                {
                };
                
                void SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(float3 Vector3_314C8600, Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                {
                    Out = A * B;
                }
                
                void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                {
                    Out = UV * Tiling + Offset;
                }
                
                void Unity_Branch_float2(float Predicate, float2 True, float2 False, out float2 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                struct Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6
                {
                    float3 AbsoluteWorldSpacePosition;
                    half4 uv0;
                };
                
                void SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float4 Vector4_2EBA7A3B, float Boolean_7ABB9909, Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 IN, out float4 XZ_2)
                {
                    float _Property_30834f691775a0898a45b1c868520436_Out_0 = Boolean_7ABB9909;
                    float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
                    float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
                    float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
                    float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
                    float4 _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0 = Vector4_2EBA7A3B;
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[0];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[1];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[2];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[3];
                    float _Divide_e64179199923c58289b6aa94ea6c9178_Out_2;
                    Unity_Divide_float(1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Divide_e64179199923c58289b6aa94ea6c9178_Out_2);
                    float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
                    Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_e64179199923c58289b6aa94ea6c9178_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
                    float2 _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2);
                    float2 _Vector2_f8d75f54e7705083bbec539a60185577_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4);
                    float2 _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0, _Vector2_f8d75f54e7705083bbec539a60185577_Out_0, _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3);
                    float2 _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3;
                    Unity_Branch_float2(_Property_30834f691775a0898a45b1c868520436_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
                    float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
                    XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7;
                    float3 _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1;
                    SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7, _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1);
                    description.Position = _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    float4 _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0 = _BaseTilingOffset;
                    float _Property_7f998178363b4188ba2f07298ef869c1_Out_0 = _BaseUsePlanarUV;
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e;
                    _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.uv0 = IN.uv0;
                    float4 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2);
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_R_1 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[0];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_G_2 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[1];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_B_3 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[2];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[3];
                    float _Property_8bc98dd454a5508b9864a6ba09772356_Out_0 = _AlphaCutoff;
                    surface.Alpha = _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4;
                    surface.AlphaClipThreshold = _Property_8bc98dd454a5508b9864a6ba09772356_Out_0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.ObjectSpacePosition =         input.positionOS;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                
                
                
                
                    output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
                    output.uv0 =                         input.texCoord0;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShadowCasterPass.hlsl"
    
                ENDHLSL
            }
            Pass
            {
                Name "DepthOnly"
                Tags
                {
                    "LightMode" = "DepthOnly"
                }
    
                // Render State
                Cull Back
                Blend One Zero
                ZTest LEqual
                ZWrite On
                ColorMask 0
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 4.5
                #pragma exclude_renderers gles gles3 glcore
                #pragma multi_compile_instancing
                #pragma multi_compile _ DOTS_INSTANCING_ON
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                // PassKeywords: <None>
                // GraphKeywords: <None>
    
                // Defines
                #define _AlphaClip 1
                #define _NORMALMAP 1
                #define _NORMAL_DROPOFF_TS 1
                #define ATTRIBUTES_NEED_NORMAL
                #define ATTRIBUTES_NEED_TANGENT
                #define ATTRIBUTES_NEED_TEXCOORD0
                #define VARYINGS_NEED_POSITION_WS
                #define VARYINGS_NEED_TEXCOORD0
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_DEPTHONLY
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    float3 positionOS : POSITION;
                    float3 normalOS : NORMAL;
                    float4 tangentOS : TANGENT;
                    float4 uv0 : TEXCOORD0;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                };
                struct Varyings
                {
                    float4 positionCS : SV_POSITION;
                    float3 positionWS;
                    float4 texCoord0;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    float3 AbsoluteWorldSpacePosition;
                    float4 uv0;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 ObjectSpacePosition;
                };
                struct PackedVaryings
                {
                    float4 positionCS : SV_POSITION;
                    float3 interp0 : TEXCOORD0;
                    float4 interp1 : TEXCOORD1;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
    
                PackedVaryings PackVaryings (Varyings input)
                {
                    PackedVaryings output;
                    output.positionCS = input.positionCS;
                    output.interp0.xyz =  input.positionWS;
                    output.interp1.xyzw =  input.texCoord0;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
                Varyings UnpackVaryings (PackedVaryings input)
                {
                    Varyings output;
                    output.positionCS = input.positionCS;
                    output.positionWS = input.interp0.xyz;
                    output.texCoord0 = input.interp1.xyzw;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _AlphaCutoff;
                float4 _BaseColor;
                float4 _BaseColorMap_TexelSize;
                float _BaseUsePlanarUV;
                float4 _BaseTilingOffset;
                float4 _BaseNormalMap_TexelSize;
                float _BaseNormalScale;
                float4 _BaseMaskMap_TexelSize;
                float _BaseMetallic;
                float _BaseAORemapMin;
                float _BaseAORemapMax;
                float _BaseSmoothnessRemapMin;
                float _BaseSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float _Invert_Layer_Mask;
                float _Height_Transition;
                float _HeightMin;
                float _HeightMax;
                float _HeightOffset;
                float _HeightMin2;
                float _HeightMax2;
                float _HeightOffset2;
                float4 _Base2Color;
                float4 _Base2ColorMap_TexelSize;
                float4 _Base2TilingOffset;
                float _Base2UsePlanarUV;
                float4 _Base2NormalMap_TexelSize;
                float _Base2NormalScale;
                float4 _Base2MaskMap_TexelSize;
                float _Base2Metallic;
                float _Base2SmoothnessRemapMin;
                float _Base2SmoothnessRemapMax;
                float _Base2AORemapMin;
                float _Base2AORemapMax;
                float4 _WetColor;
                float _WetSmoothness;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_BaseColorMap);
                SAMPLER(sampler_BaseColorMap);
                TEXTURE2D(_BaseNormalMap);
                SAMPLER(sampler_BaseNormalMap);
                TEXTURE2D(_BaseMaskMap);
                SAMPLER(sampler_BaseMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_Base2ColorMap);
                SAMPLER(sampler_Base2ColorMap);
                TEXTURE2D(_Base2NormalMap);
                SAMPLER(sampler_Base2NormalMap);
                TEXTURE2D(_Base2MaskMap);
                SAMPLER(sampler_Base2MaskMap);
                SAMPLER(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 6a9c7522090e0644e0cdf14d6feac267
                #include "Assets/NatureManufacture Assets/Object Shaders/NM_Object_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b
                {
                };
                
                void SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(float3 Vector3_314C8600, Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                {
                    Out = A * B;
                }
                
                void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                {
                    Out = UV * Tiling + Offset;
                }
                
                void Unity_Branch_float2(float Predicate, float2 True, float2 False, out float2 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                struct Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6
                {
                    float3 AbsoluteWorldSpacePosition;
                    half4 uv0;
                };
                
                void SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float4 Vector4_2EBA7A3B, float Boolean_7ABB9909, Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 IN, out float4 XZ_2)
                {
                    float _Property_30834f691775a0898a45b1c868520436_Out_0 = Boolean_7ABB9909;
                    float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
                    float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
                    float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
                    float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
                    float4 _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0 = Vector4_2EBA7A3B;
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[0];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[1];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[2];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[3];
                    float _Divide_e64179199923c58289b6aa94ea6c9178_Out_2;
                    Unity_Divide_float(1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Divide_e64179199923c58289b6aa94ea6c9178_Out_2);
                    float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
                    Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_e64179199923c58289b6aa94ea6c9178_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
                    float2 _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2);
                    float2 _Vector2_f8d75f54e7705083bbec539a60185577_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4);
                    float2 _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0, _Vector2_f8d75f54e7705083bbec539a60185577_Out_0, _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3);
                    float2 _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3;
                    Unity_Branch_float2(_Property_30834f691775a0898a45b1c868520436_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
                    float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
                    XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7;
                    float3 _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1;
                    SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7, _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1);
                    description.Position = _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    float4 _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0 = _BaseTilingOffset;
                    float _Property_7f998178363b4188ba2f07298ef869c1_Out_0 = _BaseUsePlanarUV;
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e;
                    _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.uv0 = IN.uv0;
                    float4 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2);
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_R_1 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[0];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_G_2 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[1];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_B_3 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[2];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[3];
                    float _Property_8bc98dd454a5508b9864a6ba09772356_Out_0 = _AlphaCutoff;
                    surface.Alpha = _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4;
                    surface.AlphaClipThreshold = _Property_8bc98dd454a5508b9864a6ba09772356_Out_0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.ObjectSpacePosition =         input.positionOS;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                
                
                
                
                    output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
                    output.uv0 =                         input.texCoord0;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthOnlyPass.hlsl"
    
                ENDHLSL
            }
            Pass
            {
                Name "DepthNormals"
                Tags
                {
                    "LightMode" = "DepthNormals"
                }
    
                // Render State
                Cull Back
                Blend One Zero
                ZTest LEqual
                ZWrite On
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 4.5
                #pragma exclude_renderers gles gles3 glcore
                #pragma multi_compile_instancing
                #pragma multi_compile _ DOTS_INSTANCING_ON
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                // PassKeywords: <None>
                // GraphKeywords: <None>
    
                // Defines
                #define _AlphaClip 1
                #define _NORMALMAP 1
                #define _NORMAL_DROPOFF_TS 1
                #define ATTRIBUTES_NEED_NORMAL
                #define ATTRIBUTES_NEED_TANGENT
                #define ATTRIBUTES_NEED_TEXCOORD0
                #define ATTRIBUTES_NEED_TEXCOORD1
                #define ATTRIBUTES_NEED_COLOR
                #define VARYINGS_NEED_POSITION_WS
                #define VARYINGS_NEED_NORMAL_WS
                #define VARYINGS_NEED_TANGENT_WS
                #define VARYINGS_NEED_TEXCOORD0
                #define VARYINGS_NEED_COLOR
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_DEPTHNORMALSONLY
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    float3 positionOS : POSITION;
                    float3 normalOS : NORMAL;
                    float4 tangentOS : TANGENT;
                    float4 uv0 : TEXCOORD0;
                    float4 uv1 : TEXCOORD1;
                    float4 color : COLOR;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                };
                struct Varyings
                {
                    float4 positionCS : SV_POSITION;
                    float3 positionWS;
                    float3 normalWS;
                    float4 tangentWS;
                    float4 texCoord0;
                    float4 color;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    float3 WorldSpaceNormal;
                    float3 TangentSpaceNormal;
                    float3 WorldSpaceTangent;
                    float3 WorldSpaceBiTangent;
                    float3 AbsoluteWorldSpacePosition;
                    float4 uv0;
                    float4 VertexColor;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 ObjectSpacePosition;
                };
                struct PackedVaryings
                {
                    float4 positionCS : SV_POSITION;
                    float3 interp0 : TEXCOORD0;
                    float3 interp1 : TEXCOORD1;
                    float4 interp2 : TEXCOORD2;
                    float4 interp3 : TEXCOORD3;
                    float4 interp4 : TEXCOORD4;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
    
                PackedVaryings PackVaryings (Varyings input)
                {
                    PackedVaryings output;
                    output.positionCS = input.positionCS;
                    output.interp0.xyz =  input.positionWS;
                    output.interp1.xyz =  input.normalWS;
                    output.interp2.xyzw =  input.tangentWS;
                    output.interp3.xyzw =  input.texCoord0;
                    output.interp4.xyzw =  input.color;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
                Varyings UnpackVaryings (PackedVaryings input)
                {
                    Varyings output;
                    output.positionCS = input.positionCS;
                    output.positionWS = input.interp0.xyz;
                    output.normalWS = input.interp1.xyz;
                    output.tangentWS = input.interp2.xyzw;
                    output.texCoord0 = input.interp3.xyzw;
                    output.color = input.interp4.xyzw;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _AlphaCutoff;
                float4 _BaseColor;
                float4 _BaseColorMap_TexelSize;
                float _BaseUsePlanarUV;
                float4 _BaseTilingOffset;
                float4 _BaseNormalMap_TexelSize;
                float _BaseNormalScale;
                float4 _BaseMaskMap_TexelSize;
                float _BaseMetallic;
                float _BaseAORemapMin;
                float _BaseAORemapMax;
                float _BaseSmoothnessRemapMin;
                float _BaseSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float _Invert_Layer_Mask;
                float _Height_Transition;
                float _HeightMin;
                float _HeightMax;
                float _HeightOffset;
                float _HeightMin2;
                float _HeightMax2;
                float _HeightOffset2;
                float4 _Base2Color;
                float4 _Base2ColorMap_TexelSize;
                float4 _Base2TilingOffset;
                float _Base2UsePlanarUV;
                float4 _Base2NormalMap_TexelSize;
                float _Base2NormalScale;
                float4 _Base2MaskMap_TexelSize;
                float _Base2Metallic;
                float _Base2SmoothnessRemapMin;
                float _Base2SmoothnessRemapMax;
                float _Base2AORemapMin;
                float _Base2AORemapMax;
                float4 _WetColor;
                float _WetSmoothness;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_BaseColorMap);
                SAMPLER(sampler_BaseColorMap);
                TEXTURE2D(_BaseNormalMap);
                SAMPLER(sampler_BaseNormalMap);
                TEXTURE2D(_BaseMaskMap);
                SAMPLER(sampler_BaseMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_Base2ColorMap);
                SAMPLER(sampler_Base2ColorMap);
                TEXTURE2D(_Base2NormalMap);
                SAMPLER(sampler_Base2NormalMap);
                TEXTURE2D(_Base2MaskMap);
                SAMPLER(sampler_Base2MaskMap);
                SAMPLER(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 6a9c7522090e0644e0cdf14d6feac267
                #include "Assets/NatureManufacture Assets/Object Shaders/NM_Object_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b
                {
                };
                
                void SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(float3 Vector3_314C8600, Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                {
                    Out = A * B;
                }
                
                void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                {
                    Out = UV * Tiling + Offset;
                }
                
                void Unity_Branch_float2(float Predicate, float2 True, float2 False, out float2 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Sign_float3(float3 In, out float3 Out)
                {
                    Out = sign(In);
                }
                
                void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Add_float2(float2 A, float2 B, out float2 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Normalize_float3(float3 In, out float3 Out)
                {
                    Out = normalize(In);
                }
                
                void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                struct Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8
                {
                    float3 WorldSpaceNormal;
                    float3 WorldSpaceTangent;
                    float3 WorldSpaceBiTangent;
                    float3 AbsoluteWorldSpacePosition;
                    half4 uv0;
                };
                
                void SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float4 Vector4_82674548, float Boolean_9FF42DF6, Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 IN, out float4 XZ_2)
                {
                    float _Property_1ef12cf3201a938993fe6a7951b0e754_Out_0 = Boolean_9FF42DF6;
                    float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
                    float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
                    float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
                    float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
                    float4 _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0 = Vector4_82674548;
                    float _Split_a2e12fa5931da084b2949343a539dfd8_R_1 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[0];
                    float _Split_a2e12fa5931da084b2949343a539dfd8_G_2 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[1];
                    float _Split_a2e12fa5931da084b2949343a539dfd8_B_3 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[2];
                    float _Split_a2e12fa5931da084b2949343a539dfd8_A_4 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[3];
                    float _Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2;
                    Unity_Divide_float(1, _Split_a2e12fa5931da084b2949343a539dfd8_R_1, _Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2);
                    float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
                    Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
                    float2 _Vector2_6845d21872714d889783b0cb707df3e9_Out_0 = float2(_Split_a2e12fa5931da084b2949343a539dfd8_R_1, _Split_a2e12fa5931da084b2949343a539dfd8_G_2);
                    float2 _Vector2_e2e2263627c6098e96a5b5d29350ad03_Out_0 = float2(_Split_a2e12fa5931da084b2949343a539dfd8_B_3, _Split_a2e12fa5931da084b2949343a539dfd8_A_4);
                    float2 _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_6845d21872714d889783b0cb707df3e9_Out_0, _Vector2_e2e2263627c6098e96a5b5d29350ad03_Out_0, _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3);
                    float2 _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3;
                    Unity_Branch_float2(_Property_1ef12cf3201a938993fe6a7951b0e754_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3, _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3);
                    float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3);
                    _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0);
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
                    float2 _Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0 = float2(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4, _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5);
                    float3 _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1;
                    Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1);
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_R_1 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[0];
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_G_2 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[1];
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_B_3 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[2];
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_A_4 = 0;
                    float2 _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0 = float2(_Split_6299d4ddcc4c74828aea40a46fdb896e_G_2, 1);
                    float2 _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2;
                    Unity_Multiply_float(_Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0, _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0, _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2);
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1 = IN.WorldSpaceNormal[0];
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2 = IN.WorldSpaceNormal[1];
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3 = IN.WorldSpaceNormal[2];
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_A_4 = 0;
                    float2 _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0 = float2(_Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1, _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3);
                    float2 _Add_1145b2f896593d80aa864a34e6702562_Out_2;
                    Unity_Add_float2(_Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2, _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0, _Add_1145b2f896593d80aa864a34e6702562_Out_2);
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_R_1 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[0];
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[1];
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_B_3 = 0;
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_A_4 = 0;
                    float _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6, _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2, _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2);
                    float3 _Vector3_433840b555db308b97e9b14b6a957195_Out_0 = float3(_Split_2bc77ca2d17bd78cb2383770ce50b179_R_1, _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2, _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2);
                    float3x3 Transform_c7914cc45a011c89b3f53c55afb51673_tangentTransform_World = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
                    float3 _Transform_c7914cc45a011c89b3f53c55afb51673_Out_1 = TransformWorldToTangent(_Vector3_433840b555db308b97e9b14b6a957195_Out_0.xyz, Transform_c7914cc45a011c89b3f53c55afb51673_tangentTransform_World);
                    float3 _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1;
                    Unity_Normalize_float3(_Transform_c7914cc45a011c89b3f53c55afb51673_Out_1, _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1);
                    float3 _Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3;
                    Unity_Branch_float3(_Property_1ef12cf3201a938993fe6a7951b0e754_Out_0, _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1, (_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.xyz), _Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3);
                    XZ_2 = (float4(_Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3, 1.0));
                }
                
                void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
                {
                    Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
                }
                
                struct Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6
                {
                    float3 AbsoluteWorldSpacePosition;
                    half4 uv0;
                };
                
                void SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float4 Vector4_2EBA7A3B, float Boolean_7ABB9909, Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 IN, out float4 XZ_2)
                {
                    float _Property_30834f691775a0898a45b1c868520436_Out_0 = Boolean_7ABB9909;
                    float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
                    float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
                    float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
                    float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
                    float4 _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0 = Vector4_2EBA7A3B;
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[0];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[1];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[2];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[3];
                    float _Divide_e64179199923c58289b6aa94ea6c9178_Out_2;
                    Unity_Divide_float(1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Divide_e64179199923c58289b6aa94ea6c9178_Out_2);
                    float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
                    Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_e64179199923c58289b6aa94ea6c9178_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
                    float2 _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2);
                    float2 _Vector2_f8d75f54e7705083bbec539a60185577_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4);
                    float2 _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0, _Vector2_f8d75f54e7705083bbec539a60185577_Out_0, _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3);
                    float2 _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3;
                    Unity_Branch_float2(_Property_30834f691775a0898a45b1c868520436_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
                    float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
                    XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
                }
                
                void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
                {
                    Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
                }
                
                void Unity_OneMinus_float(float In, out float Out)
                {
                    Out = 1 - In;
                }
                
                void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Maximum_float(float A, float B, out float Out)
                {
                    Out = max(A, B);
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Add_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A / B;
                }
                
                struct Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135
                {
                };
                
                void SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(float3 Vector3_88EEBB5E, float Vector1_DA0A37FA, float3 Vector3_79AA92F, float Vector1_F7E83F1E, float Vector1_1C9222A6, Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 IN, out float3 OutVector4_1)
                {
                    float3 _Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0 = Vector3_88EEBB5E;
                    float _Property_14119cc7eaf4128f991283d47cf72d85_Out_0 = Vector1_DA0A37FA;
                    float _Property_48af0ad45e3f7f82932b938695d21391_Out_0 = Vector1_DA0A37FA;
                    float _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0 = Vector1_F7E83F1E;
                    float _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2;
                    Unity_Maximum_float(_Property_48af0ad45e3f7f82932b938695d21391_Out_0, _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0, _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2);
                    float _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0 = Vector1_1C9222A6;
                    float _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2;
                    Unity_Subtract_float(_Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2, _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2);
                    float _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2;
                    Unity_Subtract_float(_Property_14119cc7eaf4128f991283d47cf72d85_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2);
                    float _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2;
                    Unity_Maximum_float(_Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2, 0, _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2);
                    float3 _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2;
                    Unity_Multiply_float(_Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0, (_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2.xxx), _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2);
                    float3 _Property_c7292b3b08585f8c8670172b9a220bf0_Out_0 = Vector3_79AA92F;
                    float _Property_5e920479576fad83ba1947728dcceab4_Out_0 = Vector1_F7E83F1E;
                    float _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2;
                    Unity_Subtract_float(_Property_5e920479576fad83ba1947728dcceab4_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2);
                    float _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2;
                    Unity_Maximum_float(_Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2, 0, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2);
                    float3 _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2;
                    Unity_Multiply_float(_Property_c7292b3b08585f8c8670172b9a220bf0_Out_0, (_Maximum_216777d30802328eab607c8fe68ba3a1_Out_2.xxx), _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2);
                    float3 _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2;
                    Unity_Add_float3(_Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2, _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2, _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2);
                    float _Add_356384b52728f583bd6e694bc1fc3738_Out_2;
                    Unity_Add_float(_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2, _Add_356384b52728f583bd6e694bc1fc3738_Out_2);
                    float _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2;
                    Unity_Maximum_float(_Add_356384b52728f583bd6e694bc1fc3738_Out_2, 1E-05, _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2);
                    float3 _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
                    Unity_Divide_float3(_Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2, (_Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2.xxx), _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2);
                    OutVector4_1 = _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7;
                    float3 _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1;
                    SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7, _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1);
                    description.Position = _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float3 NormalTS;
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    float4 _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0 = _BaseTilingOffset;
                    float _Property_7f998178363b4188ba2f07298ef869c1_Out_0 = _BaseUsePlanarUV;
                    Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8;
                    _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceTangent = IN.WorldSpaceTangent;
                    _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                    _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.uv0 = IN.uv0;
                    float4 _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2;
                    SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_ARGS(_BaseNormalMap, sampler_BaseNormalMap), _BaseNormalMap_TexelSize, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8, _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2);
                    float _Property_d4b0759cf4647e81be065ec1465ce2b4_Out_0 = _BaseNormalScale;
                    float3 _NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2;
                    Unity_NormalStrength_float((_PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2.xyz), _Property_d4b0759cf4647e81be065ec1465ce2b4_Out_0, _NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2);
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_4245c3b264047180b5c90a697d6cb278;
                    _PlanarNM_4245c3b264047180b5c90a697d6cb278.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_4245c3b264047180b5c90a697d6cb278.uv0 = IN.uv0;
                    float4 _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseMaskMap, sampler_BaseMaskMap), _BaseMaskMap_TexelSize, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_4245c3b264047180b5c90a697d6cb278, _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2);
                    float _Split_91a015dea8acd38b904ba0935328a5bc_R_1 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[0];
                    float _Split_91a015dea8acd38b904ba0935328a5bc_G_2 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[1];
                    float _Split_91a015dea8acd38b904ba0935328a5bc_B_3 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[2];
                    float _Split_91a015dea8acd38b904ba0935328a5bc_A_4 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[3];
                    float _Property_fbcff1469ebf488394a8a89ddaf0eb2a_Out_0 = _HeightMin;
                    float _Property_9df7a44c8225168683743ac60c0c3c34_Out_0 = _HeightMax;
                    float2 _Vector2_9b1e95888c28bc8893f28c02b87fa448_Out_0 = float2(_Property_fbcff1469ebf488394a8a89ddaf0eb2a_Out_0, _Property_9df7a44c8225168683743ac60c0c3c34_Out_0);
                    float _Property_29ca14fd0b712983a38d63d2dd326e96_Out_0 = _HeightOffset;
                    float2 _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2;
                    Unity_Add_float2(_Vector2_9b1e95888c28bc8893f28c02b87fa448_Out_0, (_Property_29ca14fd0b712983a38d63d2dd326e96_Out_0.xx), _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2);
                    float _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3;
                    Unity_Remap_float(_Split_91a015dea8acd38b904ba0935328a5bc_B_3, float2 (0, 1), _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3);
                    float4 _Property_86a4657df480d48e8d3ad3b036731380_Out_0 = _Base2TilingOffset;
                    float _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0 = _Base2UsePlanarUV;
                    Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf;
                    _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceTangent = IN.WorldSpaceTangent;
                    _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                    _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.uv0 = IN.uv0;
                    float4 _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2;
                    SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_ARGS(_Base2NormalMap, sampler_Base2NormalMap), _Base2NormalMap_TexelSize, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf, _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2);
                    float _Property_8c31443b776727819a663c7ddce79064_Out_0 = _Base2NormalScale;
                    float3 _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2;
                    Unity_NormalStrength_float((_PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2.xyz), _Property_8c31443b776727819a663c7ddce79064_Out_0, _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2);
                    float _Split_85f63081c1b7bc8c83d6bbf4ba6648c5_R_1 = IN.VertexColor[0];
                    float _Split_85f63081c1b7bc8c83d6bbf4ba6648c5_G_2 = IN.VertexColor[1];
                    float _Split_85f63081c1b7bc8c83d6bbf4ba6648c5_B_3 = IN.VertexColor[2];
                    float _Split_85f63081c1b7bc8c83d6bbf4ba6648c5_A_4 = IN.VertexColor[3];
                    float _Property_df2df7bb5cfc3381beee7ec454da7542_Out_0 = _Invert_Layer_Mask;
                    float4 _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0 = SAMPLE_TEXTURE2D(_LayerMask, sampler_LayerMask, IN.uv0.xy);
                    float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.r;
                    float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_G_5 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.g;
                    float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_B_6 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.b;
                    float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_A_7 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.a;
                    float _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1;
                    Unity_OneMinus_float(_SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1);
                    float _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3;
                    Unity_Branch_float(_Property_df2df7bb5cfc3381beee7ec454da7542_Out_0, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1, _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3);
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb;
                    _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.uv0 = IN.uv0;
                    float4 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_Base2MaskMap, sampler_Base2MaskMap), _Base2MaskMap_TexelSize, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2);
                    float _Split_83ec66b648ab6c84848b42686c256cd7_R_1 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[0];
                    float _Split_83ec66b648ab6c84848b42686c256cd7_G_2 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[1];
                    float _Split_83ec66b648ab6c84848b42686c256cd7_B_3 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[2];
                    float _Split_83ec66b648ab6c84848b42686c256cd7_A_4 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[3];
                    float _Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0 = _HeightMin2;
                    float _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0 = _HeightMax2;
                    float2 _Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0 = float2(_Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0, _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0);
                    float _Property_151ae2702b614585af2000f0a812960f_Out_0 = _HeightOffset2;
                    float2 _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2;
                    Unity_Add_float2(_Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0, (_Property_151ae2702b614585af2000f0a812960f_Out_0.xx), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2);
                    float _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3;
                    Unity_Remap_float(_Split_83ec66b648ab6c84848b42686c256cd7_B_3, float2 (0, 1), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3);
                    float _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2;
                    Unity_Multiply_float(_Branch_af0c5e511241ce8eae748ae487df50fa_Out_3, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2);
                    float _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2;
                    Unity_Multiply_float(_Split_85f63081c1b7bc8c83d6bbf4ba6648c5_B_3, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2);
                    float _Property_818c8af4b930138e81034c886614171d_Out_0 = _Height_Transition;
                    Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_7c09d97625efce898e21b66cd039be8b;
                    float3 _HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1;
                    SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(_NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3, _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Property_818c8af4b930138e81034c886614171d_Out_0, _HeightBlend_7c09d97625efce898e21b66cd039be8b, _HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1);
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e;
                    _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.uv0 = IN.uv0;
                    float4 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2);
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_R_1 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[0];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_G_2 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[1];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_B_3 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[2];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[3];
                    float _Property_8bc98dd454a5508b9864a6ba09772356_Out_0 = _AlphaCutoff;
                    surface.NormalTS = _HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1;
                    surface.Alpha = _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4;
                    surface.AlphaClipThreshold = _Property_8bc98dd454a5508b9864a6ba09772356_Out_0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.ObjectSpacePosition =         input.positionOS;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                	// must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
                	float3 unnormalizedNormalWS = input.normalWS;
                    const float renormFactor = 1.0 / length(unnormalizedNormalWS);
                
                	// use bitangent on the fly like in hdrp
                	// IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
                    float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
                	float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
                
                    output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
                    output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                
                	// to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
                	// This is explained in section 2.2 in "surface gradient based bump mapping framework"
                    output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
                	output.WorldSpaceBiTangent =         renormFactor*bitang;
                
                    output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
                    output.uv0 =                         input.texCoord0;
                    output.VertexColor =                 input.color;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthNormalsOnlyPass.hlsl"
    
                ENDHLSL
            }
            Pass
            {
                Name "Meta"
                Tags
                {
                    "LightMode" = "Meta"
                }
    
                // Render State
                Cull Off
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 4.5
                #pragma exclude_renderers gles gles3 glcore
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                #pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
                // GraphKeywords: <None>
    
                // Defines
                #define _AlphaClip 1
                #define _NORMALMAP 1
                #define _NORMAL_DROPOFF_TS 1
                #define ATTRIBUTES_NEED_NORMAL
                #define ATTRIBUTES_NEED_TANGENT
                #define ATTRIBUTES_NEED_TEXCOORD0
                #define ATTRIBUTES_NEED_TEXCOORD1
                #define ATTRIBUTES_NEED_TEXCOORD2
                #define ATTRIBUTES_NEED_COLOR
                #define VARYINGS_NEED_POSITION_WS
                #define VARYINGS_NEED_TEXCOORD0
                #define VARYINGS_NEED_COLOR
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_META
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    float3 positionOS : POSITION;
                    float3 normalOS : NORMAL;
                    float4 tangentOS : TANGENT;
                    float4 uv0 : TEXCOORD0;
                    float4 uv1 : TEXCOORD1;
                    float4 uv2 : TEXCOORD2;
                    float4 color : COLOR;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                };
                struct Varyings
                {
                    float4 positionCS : SV_POSITION;
                    float3 positionWS;
                    float4 texCoord0;
                    float4 color;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    float3 AbsoluteWorldSpacePosition;
                    float4 uv0;
                    float4 VertexColor;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 ObjectSpacePosition;
                };
                struct PackedVaryings
                {
                    float4 positionCS : SV_POSITION;
                    float3 interp0 : TEXCOORD0;
                    float4 interp1 : TEXCOORD1;
                    float4 interp2 : TEXCOORD2;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
    
                PackedVaryings PackVaryings (Varyings input)
                {
                    PackedVaryings output;
                    output.positionCS = input.positionCS;
                    output.interp0.xyz =  input.positionWS;
                    output.interp1.xyzw =  input.texCoord0;
                    output.interp2.xyzw =  input.color;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
                Varyings UnpackVaryings (PackedVaryings input)
                {
                    Varyings output;
                    output.positionCS = input.positionCS;
                    output.positionWS = input.interp0.xyz;
                    output.texCoord0 = input.interp1.xyzw;
                    output.color = input.interp2.xyzw;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _AlphaCutoff;
                float4 _BaseColor;
                float4 _BaseColorMap_TexelSize;
                float _BaseUsePlanarUV;
                float4 _BaseTilingOffset;
                float4 _BaseNormalMap_TexelSize;
                float _BaseNormalScale;
                float4 _BaseMaskMap_TexelSize;
                float _BaseMetallic;
                float _BaseAORemapMin;
                float _BaseAORemapMax;
                float _BaseSmoothnessRemapMin;
                float _BaseSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float _Invert_Layer_Mask;
                float _Height_Transition;
                float _HeightMin;
                float _HeightMax;
                float _HeightOffset;
                float _HeightMin2;
                float _HeightMax2;
                float _HeightOffset2;
                float4 _Base2Color;
                float4 _Base2ColorMap_TexelSize;
                float4 _Base2TilingOffset;
                float _Base2UsePlanarUV;
                float4 _Base2NormalMap_TexelSize;
                float _Base2NormalScale;
                float4 _Base2MaskMap_TexelSize;
                float _Base2Metallic;
                float _Base2SmoothnessRemapMin;
                float _Base2SmoothnessRemapMax;
                float _Base2AORemapMin;
                float _Base2AORemapMax;
                float4 _WetColor;
                float _WetSmoothness;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_BaseColorMap);
                SAMPLER(sampler_BaseColorMap);
                TEXTURE2D(_BaseNormalMap);
                SAMPLER(sampler_BaseNormalMap);
                TEXTURE2D(_BaseMaskMap);
                SAMPLER(sampler_BaseMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_Base2ColorMap);
                SAMPLER(sampler_Base2ColorMap);
                TEXTURE2D(_Base2NormalMap);
                SAMPLER(sampler_Base2NormalMap);
                TEXTURE2D(_Base2MaskMap);
                SAMPLER(sampler_Base2MaskMap);
                SAMPLER(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 6a9c7522090e0644e0cdf14d6feac267
                #include "Assets/NatureManufacture Assets/Object Shaders/NM_Object_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b
                {
                };
                
                void SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(float3 Vector3_314C8600, Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                {
                    Out = A * B;
                }
                
                void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                {
                    Out = UV * Tiling + Offset;
                }
                
                void Unity_Branch_float2(float Predicate, float2 True, float2 False, out float2 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                struct Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6
                {
                    float3 AbsoluteWorldSpacePosition;
                    half4 uv0;
                };
                
                void SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float4 Vector4_2EBA7A3B, float Boolean_7ABB9909, Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 IN, out float4 XZ_2)
                {
                    float _Property_30834f691775a0898a45b1c868520436_Out_0 = Boolean_7ABB9909;
                    float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
                    float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
                    float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
                    float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
                    float4 _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0 = Vector4_2EBA7A3B;
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[0];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[1];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[2];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[3];
                    float _Divide_e64179199923c58289b6aa94ea6c9178_Out_2;
                    Unity_Divide_float(1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Divide_e64179199923c58289b6aa94ea6c9178_Out_2);
                    float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
                    Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_e64179199923c58289b6aa94ea6c9178_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
                    float2 _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2);
                    float2 _Vector2_f8d75f54e7705083bbec539a60185577_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4);
                    float2 _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0, _Vector2_f8d75f54e7705083bbec539a60185577_Out_0, _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3);
                    float2 _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3;
                    Unity_Branch_float2(_Property_30834f691775a0898a45b1c868520436_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
                    float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
                    XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
                }
                
                void Unity_Add_float2(float2 A, float2 B, out float2 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
                {
                    Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
                }
                
                void Unity_OneMinus_float(float In, out float Out)
                {
                    Out = 1 - In;
                }
                
                void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Maximum_float(float A, float B, out float Out)
                {
                    Out = max(A, B);
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Add_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A / B;
                }
                
                struct Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135
                {
                };
                
                void SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(float3 Vector3_88EEBB5E, float Vector1_DA0A37FA, float3 Vector3_79AA92F, float Vector1_F7E83F1E, float Vector1_1C9222A6, Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 IN, out float3 OutVector4_1)
                {
                    float3 _Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0 = Vector3_88EEBB5E;
                    float _Property_14119cc7eaf4128f991283d47cf72d85_Out_0 = Vector1_DA0A37FA;
                    float _Property_48af0ad45e3f7f82932b938695d21391_Out_0 = Vector1_DA0A37FA;
                    float _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0 = Vector1_F7E83F1E;
                    float _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2;
                    Unity_Maximum_float(_Property_48af0ad45e3f7f82932b938695d21391_Out_0, _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0, _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2);
                    float _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0 = Vector1_1C9222A6;
                    float _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2;
                    Unity_Subtract_float(_Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2, _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2);
                    float _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2;
                    Unity_Subtract_float(_Property_14119cc7eaf4128f991283d47cf72d85_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2);
                    float _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2;
                    Unity_Maximum_float(_Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2, 0, _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2);
                    float3 _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2;
                    Unity_Multiply_float(_Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0, (_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2.xxx), _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2);
                    float3 _Property_c7292b3b08585f8c8670172b9a220bf0_Out_0 = Vector3_79AA92F;
                    float _Property_5e920479576fad83ba1947728dcceab4_Out_0 = Vector1_F7E83F1E;
                    float _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2;
                    Unity_Subtract_float(_Property_5e920479576fad83ba1947728dcceab4_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2);
                    float _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2;
                    Unity_Maximum_float(_Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2, 0, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2);
                    float3 _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2;
                    Unity_Multiply_float(_Property_c7292b3b08585f8c8670172b9a220bf0_Out_0, (_Maximum_216777d30802328eab607c8fe68ba3a1_Out_2.xxx), _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2);
                    float3 _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2;
                    Unity_Add_float3(_Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2, _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2, _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2);
                    float _Add_356384b52728f583bd6e694bc1fc3738_Out_2;
                    Unity_Add_float(_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2, _Add_356384b52728f583bd6e694bc1fc3738_Out_2);
                    float _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2;
                    Unity_Maximum_float(_Add_356384b52728f583bd6e694bc1fc3738_Out_2, 1E-05, _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2);
                    float3 _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
                    Unity_Divide_float3(_Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2, (_Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2.xxx), _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2);
                    OutVector4_1 = _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
                }
                
                void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
                {
                    Out = lerp(A, B, T);
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7;
                    float3 _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1;
                    SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7, _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1);
                    description.Position = _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float3 BaseColor;
                    float3 Emission;
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    float4 _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0 = _BaseTilingOffset;
                    float _Property_7f998178363b4188ba2f07298ef869c1_Out_0 = _BaseUsePlanarUV;
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e;
                    _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.uv0 = IN.uv0;
                    float4 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2);
                    float4 _Property_b83097c58639858680bf43881a95b0af_Out_0 = _BaseColor;
                    float4 _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2;
                    Unity_Multiply_float(_PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2, _Property_b83097c58639858680bf43881a95b0af_Out_0, _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2);
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_4245c3b264047180b5c90a697d6cb278;
                    _PlanarNM_4245c3b264047180b5c90a697d6cb278.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_4245c3b264047180b5c90a697d6cb278.uv0 = IN.uv0;
                    float4 _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseMaskMap, sampler_BaseMaskMap), _BaseMaskMap_TexelSize, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_4245c3b264047180b5c90a697d6cb278, _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2);
                    float _Split_91a015dea8acd38b904ba0935328a5bc_R_1 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[0];
                    float _Split_91a015dea8acd38b904ba0935328a5bc_G_2 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[1];
                    float _Split_91a015dea8acd38b904ba0935328a5bc_B_3 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[2];
                    float _Split_91a015dea8acd38b904ba0935328a5bc_A_4 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[3];
                    float _Property_fbcff1469ebf488394a8a89ddaf0eb2a_Out_0 = _HeightMin;
                    float _Property_9df7a44c8225168683743ac60c0c3c34_Out_0 = _HeightMax;
                    float2 _Vector2_9b1e95888c28bc8893f28c02b87fa448_Out_0 = float2(_Property_fbcff1469ebf488394a8a89ddaf0eb2a_Out_0, _Property_9df7a44c8225168683743ac60c0c3c34_Out_0);
                    float _Property_29ca14fd0b712983a38d63d2dd326e96_Out_0 = _HeightOffset;
                    float2 _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2;
                    Unity_Add_float2(_Vector2_9b1e95888c28bc8893f28c02b87fa448_Out_0, (_Property_29ca14fd0b712983a38d63d2dd326e96_Out_0.xx), _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2);
                    float _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3;
                    Unity_Remap_float(_Split_91a015dea8acd38b904ba0935328a5bc_B_3, float2 (0, 1), _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3);
                    float4 _Property_86a4657df480d48e8d3ad3b036731380_Out_0 = _Base2TilingOffset;
                    float _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0 = _Base2UsePlanarUV;
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4;
                    _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.uv0 = IN.uv0;
                    float4 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_Base2ColorMap, sampler_Base2ColorMap), _Base2ColorMap_TexelSize, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2);
                    float4 _Property_3561b11b899bda8e855826445cf628aa_Out_0 = _Base2Color;
                    float4 _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2;
                    Unity_Multiply_float(_PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2, _Property_3561b11b899bda8e855826445cf628aa_Out_0, _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2);
                    float _Split_85f63081c1b7bc8c83d6bbf4ba6648c5_R_1 = IN.VertexColor[0];
                    float _Split_85f63081c1b7bc8c83d6bbf4ba6648c5_G_2 = IN.VertexColor[1];
                    float _Split_85f63081c1b7bc8c83d6bbf4ba6648c5_B_3 = IN.VertexColor[2];
                    float _Split_85f63081c1b7bc8c83d6bbf4ba6648c5_A_4 = IN.VertexColor[3];
                    float _Property_df2df7bb5cfc3381beee7ec454da7542_Out_0 = _Invert_Layer_Mask;
                    float4 _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0 = SAMPLE_TEXTURE2D(_LayerMask, sampler_LayerMask, IN.uv0.xy);
                    float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.r;
                    float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_G_5 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.g;
                    float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_B_6 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.b;
                    float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_A_7 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.a;
                    float _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1;
                    Unity_OneMinus_float(_SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1);
                    float _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3;
                    Unity_Branch_float(_Property_df2df7bb5cfc3381beee7ec454da7542_Out_0, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1, _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3);
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb;
                    _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.uv0 = IN.uv0;
                    float4 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_Base2MaskMap, sampler_Base2MaskMap), _Base2MaskMap_TexelSize, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2);
                    float _Split_83ec66b648ab6c84848b42686c256cd7_R_1 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[0];
                    float _Split_83ec66b648ab6c84848b42686c256cd7_G_2 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[1];
                    float _Split_83ec66b648ab6c84848b42686c256cd7_B_3 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[2];
                    float _Split_83ec66b648ab6c84848b42686c256cd7_A_4 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[3];
                    float _Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0 = _HeightMin2;
                    float _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0 = _HeightMax2;
                    float2 _Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0 = float2(_Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0, _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0);
                    float _Property_151ae2702b614585af2000f0a812960f_Out_0 = _HeightOffset2;
                    float2 _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2;
                    Unity_Add_float2(_Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0, (_Property_151ae2702b614585af2000f0a812960f_Out_0.xx), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2);
                    float _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3;
                    Unity_Remap_float(_Split_83ec66b648ab6c84848b42686c256cd7_B_3, float2 (0, 1), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3);
                    float _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2;
                    Unity_Multiply_float(_Branch_af0c5e511241ce8eae748ae487df50fa_Out_3, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2);
                    float _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2;
                    Unity_Multiply_float(_Split_85f63081c1b7bc8c83d6bbf4ba6648c5_B_3, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2);
                    float _Property_818c8af4b930138e81034c886614171d_Out_0 = _Height_Transition;
                    Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_7501025b3a60738a9a9d362e35a9ab48;
                    float3 _HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1;
                    SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135((_Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2.xyz), _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3, (_Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2.xyz), _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Property_818c8af4b930138e81034c886614171d_Out_0, _HeightBlend_7501025b3a60738a9a9d362e35a9ab48, _HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1);
                    float4 _Property_696647de24586381a15debb755f8f569_Out_0 = _WetColor;
                    float3 _Multiply_dec52e2895a185829e24dfeaeeba8184_Out_2;
                    Unity_Multiply_float((_Property_696647de24586381a15debb755f8f569_Out_0.xyz), _HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1, _Multiply_dec52e2895a185829e24dfeaeeba8184_Out_2);
                    float _OneMinus_0b9ce7d9f924bf8193dc9bdd9b2268e1_Out_1;
                    Unity_OneMinus_float(_Split_85f63081c1b7bc8c83d6bbf4ba6648c5_R_1, _OneMinus_0b9ce7d9f924bf8193dc9bdd9b2268e1_Out_1);
                    float3 _Lerp_7a7642d5ea869889935d4d1799cc7ad3_Out_3;
                    Unity_Lerp_float3(_HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1, _Multiply_dec52e2895a185829e24dfeaeeba8184_Out_2, (_OneMinus_0b9ce7d9f924bf8193dc9bdd9b2268e1_Out_1.xxx), _Lerp_7a7642d5ea869889935d4d1799cc7ad3_Out_3);
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_R_1 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[0];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_G_2 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[1];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_B_3 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[2];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[3];
                    float _Property_8bc98dd454a5508b9864a6ba09772356_Out_0 = _AlphaCutoff;
                    surface.BaseColor = _Lerp_7a7642d5ea869889935d4d1799cc7ad3_Out_3;
                    surface.Emission = float3(0, 0, 0);
                    surface.Alpha = _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4;
                    surface.AlphaClipThreshold = _Property_8bc98dd454a5508b9864a6ba09772356_Out_0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.ObjectSpacePosition =         input.positionOS;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                
                
                
                
                    output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
                    output.uv0 =                         input.texCoord0;
                    output.VertexColor =                 input.color;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/LightingMetaPass.hlsl"
    
                ENDHLSL
            }
            Pass
            {
                // Name: <None>
                Tags
                {
                    "LightMode" = "Universal2D"
                }
    
                // Render State
                Cull Back
                Blend One Zero
                ZTest LEqual
                ZWrite On
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 4.5
                #pragma exclude_renderers gles gles3 glcore
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                // PassKeywords: <None>
                // GraphKeywords: <None>
    
                // Defines
                #define _AlphaClip 1
                #define _NORMALMAP 1
                #define _NORMAL_DROPOFF_TS 1
                #define ATTRIBUTES_NEED_NORMAL
                #define ATTRIBUTES_NEED_TANGENT
                #define ATTRIBUTES_NEED_TEXCOORD0
                #define ATTRIBUTES_NEED_COLOR
                #define VARYINGS_NEED_POSITION_WS
                #define VARYINGS_NEED_TEXCOORD0
                #define VARYINGS_NEED_COLOR
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_2D
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    float3 positionOS : POSITION;
                    float3 normalOS : NORMAL;
                    float4 tangentOS : TANGENT;
                    float4 uv0 : TEXCOORD0;
                    float4 color : COLOR;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                };
                struct Varyings
                {
                    float4 positionCS : SV_POSITION;
                    float3 positionWS;
                    float4 texCoord0;
                    float4 color;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    float3 AbsoluteWorldSpacePosition;
                    float4 uv0;
                    float4 VertexColor;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 ObjectSpacePosition;
                };
                struct PackedVaryings
                {
                    float4 positionCS : SV_POSITION;
                    float3 interp0 : TEXCOORD0;
                    float4 interp1 : TEXCOORD1;
                    float4 interp2 : TEXCOORD2;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
    
                PackedVaryings PackVaryings (Varyings input)
                {
                    PackedVaryings output;
                    output.positionCS = input.positionCS;
                    output.interp0.xyz =  input.positionWS;
                    output.interp1.xyzw =  input.texCoord0;
                    output.interp2.xyzw =  input.color;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
                Varyings UnpackVaryings (PackedVaryings input)
                {
                    Varyings output;
                    output.positionCS = input.positionCS;
                    output.positionWS = input.interp0.xyz;
                    output.texCoord0 = input.interp1.xyzw;
                    output.color = input.interp2.xyzw;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _AlphaCutoff;
                float4 _BaseColor;
                float4 _BaseColorMap_TexelSize;
                float _BaseUsePlanarUV;
                float4 _BaseTilingOffset;
                float4 _BaseNormalMap_TexelSize;
                float _BaseNormalScale;
                float4 _BaseMaskMap_TexelSize;
                float _BaseMetallic;
                float _BaseAORemapMin;
                float _BaseAORemapMax;
                float _BaseSmoothnessRemapMin;
                float _BaseSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float _Invert_Layer_Mask;
                float _Height_Transition;
                float _HeightMin;
                float _HeightMax;
                float _HeightOffset;
                float _HeightMin2;
                float _HeightMax2;
                float _HeightOffset2;
                float4 _Base2Color;
                float4 _Base2ColorMap_TexelSize;
                float4 _Base2TilingOffset;
                float _Base2UsePlanarUV;
                float4 _Base2NormalMap_TexelSize;
                float _Base2NormalScale;
                float4 _Base2MaskMap_TexelSize;
                float _Base2Metallic;
                float _Base2SmoothnessRemapMin;
                float _Base2SmoothnessRemapMax;
                float _Base2AORemapMin;
                float _Base2AORemapMax;
                float4 _WetColor;
                float _WetSmoothness;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_BaseColorMap);
                SAMPLER(sampler_BaseColorMap);
                TEXTURE2D(_BaseNormalMap);
                SAMPLER(sampler_BaseNormalMap);
                TEXTURE2D(_BaseMaskMap);
                SAMPLER(sampler_BaseMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_Base2ColorMap);
                SAMPLER(sampler_Base2ColorMap);
                TEXTURE2D(_Base2NormalMap);
                SAMPLER(sampler_Base2NormalMap);
                TEXTURE2D(_Base2MaskMap);
                SAMPLER(sampler_Base2MaskMap);
                SAMPLER(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 6a9c7522090e0644e0cdf14d6feac267
                #include "Assets/NatureManufacture Assets/Object Shaders/NM_Object_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b
                {
                };
                
                void SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(float3 Vector3_314C8600, Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                {
                    Out = A * B;
                }
                
                void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                {
                    Out = UV * Tiling + Offset;
                }
                
                void Unity_Branch_float2(float Predicate, float2 True, float2 False, out float2 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                struct Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6
                {
                    float3 AbsoluteWorldSpacePosition;
                    half4 uv0;
                };
                
                void SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float4 Vector4_2EBA7A3B, float Boolean_7ABB9909, Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 IN, out float4 XZ_2)
                {
                    float _Property_30834f691775a0898a45b1c868520436_Out_0 = Boolean_7ABB9909;
                    float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
                    float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
                    float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
                    float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
                    float4 _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0 = Vector4_2EBA7A3B;
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[0];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[1];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[2];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[3];
                    float _Divide_e64179199923c58289b6aa94ea6c9178_Out_2;
                    Unity_Divide_float(1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Divide_e64179199923c58289b6aa94ea6c9178_Out_2);
                    float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
                    Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_e64179199923c58289b6aa94ea6c9178_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
                    float2 _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2);
                    float2 _Vector2_f8d75f54e7705083bbec539a60185577_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4);
                    float2 _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0, _Vector2_f8d75f54e7705083bbec539a60185577_Out_0, _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3);
                    float2 _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3;
                    Unity_Branch_float2(_Property_30834f691775a0898a45b1c868520436_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
                    float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
                    XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
                }
                
                void Unity_Add_float2(float2 A, float2 B, out float2 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
                {
                    Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
                }
                
                void Unity_OneMinus_float(float In, out float Out)
                {
                    Out = 1 - In;
                }
                
                void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Maximum_float(float A, float B, out float Out)
                {
                    Out = max(A, B);
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Add_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A / B;
                }
                
                struct Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135
                {
                };
                
                void SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(float3 Vector3_88EEBB5E, float Vector1_DA0A37FA, float3 Vector3_79AA92F, float Vector1_F7E83F1E, float Vector1_1C9222A6, Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 IN, out float3 OutVector4_1)
                {
                    float3 _Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0 = Vector3_88EEBB5E;
                    float _Property_14119cc7eaf4128f991283d47cf72d85_Out_0 = Vector1_DA0A37FA;
                    float _Property_48af0ad45e3f7f82932b938695d21391_Out_0 = Vector1_DA0A37FA;
                    float _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0 = Vector1_F7E83F1E;
                    float _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2;
                    Unity_Maximum_float(_Property_48af0ad45e3f7f82932b938695d21391_Out_0, _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0, _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2);
                    float _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0 = Vector1_1C9222A6;
                    float _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2;
                    Unity_Subtract_float(_Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2, _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2);
                    float _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2;
                    Unity_Subtract_float(_Property_14119cc7eaf4128f991283d47cf72d85_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2);
                    float _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2;
                    Unity_Maximum_float(_Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2, 0, _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2);
                    float3 _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2;
                    Unity_Multiply_float(_Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0, (_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2.xxx), _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2);
                    float3 _Property_c7292b3b08585f8c8670172b9a220bf0_Out_0 = Vector3_79AA92F;
                    float _Property_5e920479576fad83ba1947728dcceab4_Out_0 = Vector1_F7E83F1E;
                    float _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2;
                    Unity_Subtract_float(_Property_5e920479576fad83ba1947728dcceab4_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2);
                    float _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2;
                    Unity_Maximum_float(_Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2, 0, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2);
                    float3 _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2;
                    Unity_Multiply_float(_Property_c7292b3b08585f8c8670172b9a220bf0_Out_0, (_Maximum_216777d30802328eab607c8fe68ba3a1_Out_2.xxx), _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2);
                    float3 _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2;
                    Unity_Add_float3(_Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2, _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2, _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2);
                    float _Add_356384b52728f583bd6e694bc1fc3738_Out_2;
                    Unity_Add_float(_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2, _Add_356384b52728f583bd6e694bc1fc3738_Out_2);
                    float _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2;
                    Unity_Maximum_float(_Add_356384b52728f583bd6e694bc1fc3738_Out_2, 1E-05, _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2);
                    float3 _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
                    Unity_Divide_float3(_Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2, (_Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2.xxx), _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2);
                    OutVector4_1 = _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
                }
                
                void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
                {
                    Out = lerp(A, B, T);
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7;
                    float3 _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1;
                    SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7, _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1);
                    description.Position = _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float3 BaseColor;
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    float4 _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0 = _BaseTilingOffset;
                    float _Property_7f998178363b4188ba2f07298ef869c1_Out_0 = _BaseUsePlanarUV;
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e;
                    _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.uv0 = IN.uv0;
                    float4 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2);
                    float4 _Property_b83097c58639858680bf43881a95b0af_Out_0 = _BaseColor;
                    float4 _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2;
                    Unity_Multiply_float(_PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2, _Property_b83097c58639858680bf43881a95b0af_Out_0, _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2);
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_4245c3b264047180b5c90a697d6cb278;
                    _PlanarNM_4245c3b264047180b5c90a697d6cb278.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_4245c3b264047180b5c90a697d6cb278.uv0 = IN.uv0;
                    float4 _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseMaskMap, sampler_BaseMaskMap), _BaseMaskMap_TexelSize, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_4245c3b264047180b5c90a697d6cb278, _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2);
                    float _Split_91a015dea8acd38b904ba0935328a5bc_R_1 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[0];
                    float _Split_91a015dea8acd38b904ba0935328a5bc_G_2 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[1];
                    float _Split_91a015dea8acd38b904ba0935328a5bc_B_3 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[2];
                    float _Split_91a015dea8acd38b904ba0935328a5bc_A_4 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[3];
                    float _Property_fbcff1469ebf488394a8a89ddaf0eb2a_Out_0 = _HeightMin;
                    float _Property_9df7a44c8225168683743ac60c0c3c34_Out_0 = _HeightMax;
                    float2 _Vector2_9b1e95888c28bc8893f28c02b87fa448_Out_0 = float2(_Property_fbcff1469ebf488394a8a89ddaf0eb2a_Out_0, _Property_9df7a44c8225168683743ac60c0c3c34_Out_0);
                    float _Property_29ca14fd0b712983a38d63d2dd326e96_Out_0 = _HeightOffset;
                    float2 _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2;
                    Unity_Add_float2(_Vector2_9b1e95888c28bc8893f28c02b87fa448_Out_0, (_Property_29ca14fd0b712983a38d63d2dd326e96_Out_0.xx), _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2);
                    float _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3;
                    Unity_Remap_float(_Split_91a015dea8acd38b904ba0935328a5bc_B_3, float2 (0, 1), _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3);
                    float4 _Property_86a4657df480d48e8d3ad3b036731380_Out_0 = _Base2TilingOffset;
                    float _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0 = _Base2UsePlanarUV;
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4;
                    _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.uv0 = IN.uv0;
                    float4 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_Base2ColorMap, sampler_Base2ColorMap), _Base2ColorMap_TexelSize, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2);
                    float4 _Property_3561b11b899bda8e855826445cf628aa_Out_0 = _Base2Color;
                    float4 _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2;
                    Unity_Multiply_float(_PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2, _Property_3561b11b899bda8e855826445cf628aa_Out_0, _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2);
                    float _Split_85f63081c1b7bc8c83d6bbf4ba6648c5_R_1 = IN.VertexColor[0];
                    float _Split_85f63081c1b7bc8c83d6bbf4ba6648c5_G_2 = IN.VertexColor[1];
                    float _Split_85f63081c1b7bc8c83d6bbf4ba6648c5_B_3 = IN.VertexColor[2];
                    float _Split_85f63081c1b7bc8c83d6bbf4ba6648c5_A_4 = IN.VertexColor[3];
                    float _Property_df2df7bb5cfc3381beee7ec454da7542_Out_0 = _Invert_Layer_Mask;
                    float4 _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0 = SAMPLE_TEXTURE2D(_LayerMask, sampler_LayerMask, IN.uv0.xy);
                    float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.r;
                    float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_G_5 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.g;
                    float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_B_6 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.b;
                    float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_A_7 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.a;
                    float _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1;
                    Unity_OneMinus_float(_SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1);
                    float _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3;
                    Unity_Branch_float(_Property_df2df7bb5cfc3381beee7ec454da7542_Out_0, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1, _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3);
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb;
                    _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.uv0 = IN.uv0;
                    float4 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_Base2MaskMap, sampler_Base2MaskMap), _Base2MaskMap_TexelSize, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2);
                    float _Split_83ec66b648ab6c84848b42686c256cd7_R_1 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[0];
                    float _Split_83ec66b648ab6c84848b42686c256cd7_G_2 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[1];
                    float _Split_83ec66b648ab6c84848b42686c256cd7_B_3 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[2];
                    float _Split_83ec66b648ab6c84848b42686c256cd7_A_4 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[3];
                    float _Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0 = _HeightMin2;
                    float _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0 = _HeightMax2;
                    float2 _Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0 = float2(_Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0, _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0);
                    float _Property_151ae2702b614585af2000f0a812960f_Out_0 = _HeightOffset2;
                    float2 _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2;
                    Unity_Add_float2(_Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0, (_Property_151ae2702b614585af2000f0a812960f_Out_0.xx), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2);
                    float _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3;
                    Unity_Remap_float(_Split_83ec66b648ab6c84848b42686c256cd7_B_3, float2 (0, 1), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3);
                    float _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2;
                    Unity_Multiply_float(_Branch_af0c5e511241ce8eae748ae487df50fa_Out_3, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2);
                    float _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2;
                    Unity_Multiply_float(_Split_85f63081c1b7bc8c83d6bbf4ba6648c5_B_3, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2);
                    float _Property_818c8af4b930138e81034c886614171d_Out_0 = _Height_Transition;
                    Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_7501025b3a60738a9a9d362e35a9ab48;
                    float3 _HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1;
                    SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135((_Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2.xyz), _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3, (_Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2.xyz), _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Property_818c8af4b930138e81034c886614171d_Out_0, _HeightBlend_7501025b3a60738a9a9d362e35a9ab48, _HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1);
                    float4 _Property_696647de24586381a15debb755f8f569_Out_0 = _WetColor;
                    float3 _Multiply_dec52e2895a185829e24dfeaeeba8184_Out_2;
                    Unity_Multiply_float((_Property_696647de24586381a15debb755f8f569_Out_0.xyz), _HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1, _Multiply_dec52e2895a185829e24dfeaeeba8184_Out_2);
                    float _OneMinus_0b9ce7d9f924bf8193dc9bdd9b2268e1_Out_1;
                    Unity_OneMinus_float(_Split_85f63081c1b7bc8c83d6bbf4ba6648c5_R_1, _OneMinus_0b9ce7d9f924bf8193dc9bdd9b2268e1_Out_1);
                    float3 _Lerp_7a7642d5ea869889935d4d1799cc7ad3_Out_3;
                    Unity_Lerp_float3(_HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1, _Multiply_dec52e2895a185829e24dfeaeeba8184_Out_2, (_OneMinus_0b9ce7d9f924bf8193dc9bdd9b2268e1_Out_1.xxx), _Lerp_7a7642d5ea869889935d4d1799cc7ad3_Out_3);
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_R_1 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[0];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_G_2 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[1];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_B_3 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[2];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[3];
                    float _Property_8bc98dd454a5508b9864a6ba09772356_Out_0 = _AlphaCutoff;
                    surface.BaseColor = _Lerp_7a7642d5ea869889935d4d1799cc7ad3_Out_3;
                    surface.Alpha = _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4;
                    surface.AlphaClipThreshold = _Property_8bc98dd454a5508b9864a6ba09772356_Out_0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.ObjectSpacePosition =         input.positionOS;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                
                
                
                
                    output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
                    output.uv0 =                         input.texCoord0;
                    output.VertexColor =                 input.color;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBR2DPass.hlsl"
    
                ENDHLSL
            }
        }
        SubShader
        {
            Tags
            {
                "RenderPipeline"="UniversalPipeline"
                "RenderType"="Opaque"
                "UniversalMaterialType" = "Lit"
                "Queue"="AlphaTest"
            }
            Pass
            {
                Name "Universal Forward"
                Tags
                {
                    "LightMode" = "UniversalForward"
                }
    
                // Render State
                Cull Back
                Blend One Zero
                ZTest LEqual
                ZWrite On
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 2.0
                #pragma only_renderers gles gles3 glcore
                #pragma multi_compile_instancing
                #pragma multi_compile_fog
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                #pragma multi_compile _ _SCREEN_SPACE_OCCLUSION
                #pragma multi_compile _ LIGHTMAP_ON
                #pragma multi_compile _ DIRLIGHTMAP_COMBINED
                #pragma multi_compile _ _MAIN_LIGHT_SHADOWS
                #pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
                #pragma multi_compile _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS _ADDITIONAL_OFF
                #pragma multi_compile _ _ADDITIONAL_LIGHT_SHADOWS
                #pragma multi_compile _ _SHADOWS_SOFT
                #pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
                #pragma multi_compile _ SHADOWS_SHADOWMASK
                // GraphKeywords: <None>
    
                // Defines
                #define _AlphaClip 1
                #define _NORMALMAP 1
                #define _NORMAL_DROPOFF_TS 1
                #define ATTRIBUTES_NEED_NORMAL
                #define ATTRIBUTES_NEED_TANGENT
                #define ATTRIBUTES_NEED_TEXCOORD0
                #define ATTRIBUTES_NEED_TEXCOORD1
                #define ATTRIBUTES_NEED_COLOR
                #define VARYINGS_NEED_POSITION_WS
                #define VARYINGS_NEED_NORMAL_WS
                #define VARYINGS_NEED_TANGENT_WS
                #define VARYINGS_NEED_TEXCOORD0
                #define VARYINGS_NEED_COLOR
                #define VARYINGS_NEED_VIEWDIRECTION_WS
                #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_FORWARD
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    float3 positionOS : POSITION;
                    float3 normalOS : NORMAL;
                    float4 tangentOS : TANGENT;
                    float4 uv0 : TEXCOORD0;
                    float4 uv1 : TEXCOORD1;
                    float4 color : COLOR;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                };
                struct Varyings
                {
                    float4 positionCS : SV_POSITION;
                    float3 positionWS;
                    float3 normalWS;
                    float4 tangentWS;
                    float4 texCoord0;
                    float4 color;
                    float3 viewDirectionWS;
                    #if defined(LIGHTMAP_ON)
                    float2 lightmapUV;
                    #endif
                    #if !defined(LIGHTMAP_ON)
                    float3 sh;
                    #endif
                    float4 fogFactorAndVertexLight;
                    float4 shadowCoord;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    float3 WorldSpaceNormal;
                    float3 TangentSpaceNormal;
                    float3 WorldSpaceTangent;
                    float3 WorldSpaceBiTangent;
                    float3 AbsoluteWorldSpacePosition;
                    float4 uv0;
                    float4 VertexColor;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 ObjectSpacePosition;
                };
                struct PackedVaryings
                {
                    float4 positionCS : SV_POSITION;
                    float3 interp0 : TEXCOORD0;
                    float3 interp1 : TEXCOORD1;
                    float4 interp2 : TEXCOORD2;
                    float4 interp3 : TEXCOORD3;
                    float4 interp4 : TEXCOORD4;
                    float3 interp5 : TEXCOORD5;
                    #if defined(LIGHTMAP_ON)
                    float2 interp6 : TEXCOORD6;
                    #endif
                    #if !defined(LIGHTMAP_ON)
                    float3 interp7 : TEXCOORD7;
                    #endif
                    float4 interp8 : TEXCOORD8;
                    float4 interp9 : TEXCOORD9;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
    
                PackedVaryings PackVaryings (Varyings input)
                {
                    PackedVaryings output;
                    output.positionCS = input.positionCS;
                    output.interp0.xyz =  input.positionWS;
                    output.interp1.xyz =  input.normalWS;
                    output.interp2.xyzw =  input.tangentWS;
                    output.interp3.xyzw =  input.texCoord0;
                    output.interp4.xyzw =  input.color;
                    output.interp5.xyz =  input.viewDirectionWS;
                    #if defined(LIGHTMAP_ON)
                    output.interp6.xy =  input.lightmapUV;
                    #endif
                    #if !defined(LIGHTMAP_ON)
                    output.interp7.xyz =  input.sh;
                    #endif
                    output.interp8.xyzw =  input.fogFactorAndVertexLight;
                    output.interp9.xyzw =  input.shadowCoord;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
                Varyings UnpackVaryings (PackedVaryings input)
                {
                    Varyings output;
                    output.positionCS = input.positionCS;
                    output.positionWS = input.interp0.xyz;
                    output.normalWS = input.interp1.xyz;
                    output.tangentWS = input.interp2.xyzw;
                    output.texCoord0 = input.interp3.xyzw;
                    output.color = input.interp4.xyzw;
                    output.viewDirectionWS = input.interp5.xyz;
                    #if defined(LIGHTMAP_ON)
                    output.lightmapUV = input.interp6.xy;
                    #endif
                    #if !defined(LIGHTMAP_ON)
                    output.sh = input.interp7.xyz;
                    #endif
                    output.fogFactorAndVertexLight = input.interp8.xyzw;
                    output.shadowCoord = input.interp9.xyzw;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _AlphaCutoff;
                float4 _BaseColor;
                float4 _BaseColorMap_TexelSize;
                float _BaseUsePlanarUV;
                float4 _BaseTilingOffset;
                float4 _BaseNormalMap_TexelSize;
                float _BaseNormalScale;
                float4 _BaseMaskMap_TexelSize;
                float _BaseMetallic;
                float _BaseAORemapMin;
                float _BaseAORemapMax;
                float _BaseSmoothnessRemapMin;
                float _BaseSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float _Invert_Layer_Mask;
                float _Height_Transition;
                float _HeightMin;
                float _HeightMax;
                float _HeightOffset;
                float _HeightMin2;
                float _HeightMax2;
                float _HeightOffset2;
                float4 _Base2Color;
                float4 _Base2ColorMap_TexelSize;
                float4 _Base2TilingOffset;
                float _Base2UsePlanarUV;
                float4 _Base2NormalMap_TexelSize;
                float _Base2NormalScale;
                float4 _Base2MaskMap_TexelSize;
                float _Base2Metallic;
                float _Base2SmoothnessRemapMin;
                float _Base2SmoothnessRemapMax;
                float _Base2AORemapMin;
                float _Base2AORemapMax;
                float4 _WetColor;
                float _WetSmoothness;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_BaseColorMap);
                SAMPLER(sampler_BaseColorMap);
                TEXTURE2D(_BaseNormalMap);
                SAMPLER(sampler_BaseNormalMap);
                TEXTURE2D(_BaseMaskMap);
                SAMPLER(sampler_BaseMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_Base2ColorMap);
                SAMPLER(sampler_Base2ColorMap);
                TEXTURE2D(_Base2NormalMap);
                SAMPLER(sampler_Base2NormalMap);
                TEXTURE2D(_Base2MaskMap);
                SAMPLER(sampler_Base2MaskMap);
                SAMPLER(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 6a9c7522090e0644e0cdf14d6feac267
                #include "Assets/NatureManufacture Assets/Object Shaders/NM_Object_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b
                {
                };
                
                void SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(float3 Vector3_314C8600, Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                {
                    Out = A * B;
                }
                
                void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                {
                    Out = UV * Tiling + Offset;
                }
                
                void Unity_Branch_float2(float Predicate, float2 True, float2 False, out float2 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                struct Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6
                {
                    float3 AbsoluteWorldSpacePosition;
                    half4 uv0;
                };
                
                void SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float4 Vector4_2EBA7A3B, float Boolean_7ABB9909, Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 IN, out float4 XZ_2)
                {
                    float _Property_30834f691775a0898a45b1c868520436_Out_0 = Boolean_7ABB9909;
                    float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
                    float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
                    float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
                    float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
                    float4 _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0 = Vector4_2EBA7A3B;
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[0];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[1];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[2];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[3];
                    float _Divide_e64179199923c58289b6aa94ea6c9178_Out_2;
                    Unity_Divide_float(1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Divide_e64179199923c58289b6aa94ea6c9178_Out_2);
                    float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
                    Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_e64179199923c58289b6aa94ea6c9178_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
                    float2 _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2);
                    float2 _Vector2_f8d75f54e7705083bbec539a60185577_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4);
                    float2 _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0, _Vector2_f8d75f54e7705083bbec539a60185577_Out_0, _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3);
                    float2 _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3;
                    Unity_Branch_float2(_Property_30834f691775a0898a45b1c868520436_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
                    float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
                    XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
                }
                
                void Unity_Add_float2(float2 A, float2 B, out float2 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
                {
                    Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
                }
                
                void Unity_OneMinus_float(float In, out float Out)
                {
                    Out = 1 - In;
                }
                
                void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Maximum_float(float A, float B, out float Out)
                {
                    Out = max(A, B);
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Add_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A / B;
                }
                
                struct Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135
                {
                };
                
                void SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(float3 Vector3_88EEBB5E, float Vector1_DA0A37FA, float3 Vector3_79AA92F, float Vector1_F7E83F1E, float Vector1_1C9222A6, Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 IN, out float3 OutVector4_1)
                {
                    float3 _Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0 = Vector3_88EEBB5E;
                    float _Property_14119cc7eaf4128f991283d47cf72d85_Out_0 = Vector1_DA0A37FA;
                    float _Property_48af0ad45e3f7f82932b938695d21391_Out_0 = Vector1_DA0A37FA;
                    float _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0 = Vector1_F7E83F1E;
                    float _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2;
                    Unity_Maximum_float(_Property_48af0ad45e3f7f82932b938695d21391_Out_0, _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0, _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2);
                    float _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0 = Vector1_1C9222A6;
                    float _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2;
                    Unity_Subtract_float(_Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2, _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2);
                    float _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2;
                    Unity_Subtract_float(_Property_14119cc7eaf4128f991283d47cf72d85_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2);
                    float _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2;
                    Unity_Maximum_float(_Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2, 0, _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2);
                    float3 _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2;
                    Unity_Multiply_float(_Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0, (_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2.xxx), _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2);
                    float3 _Property_c7292b3b08585f8c8670172b9a220bf0_Out_0 = Vector3_79AA92F;
                    float _Property_5e920479576fad83ba1947728dcceab4_Out_0 = Vector1_F7E83F1E;
                    float _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2;
                    Unity_Subtract_float(_Property_5e920479576fad83ba1947728dcceab4_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2);
                    float _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2;
                    Unity_Maximum_float(_Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2, 0, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2);
                    float3 _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2;
                    Unity_Multiply_float(_Property_c7292b3b08585f8c8670172b9a220bf0_Out_0, (_Maximum_216777d30802328eab607c8fe68ba3a1_Out_2.xxx), _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2);
                    float3 _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2;
                    Unity_Add_float3(_Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2, _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2, _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2);
                    float _Add_356384b52728f583bd6e694bc1fc3738_Out_2;
                    Unity_Add_float(_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2, _Add_356384b52728f583bd6e694bc1fc3738_Out_2);
                    float _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2;
                    Unity_Maximum_float(_Add_356384b52728f583bd6e694bc1fc3738_Out_2, 1E-05, _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2);
                    float3 _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
                    Unity_Divide_float3(_Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2, (_Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2.xxx), _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2);
                    OutVector4_1 = _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
                }
                
                void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
                {
                    Out = lerp(A, B, T);
                }
                
                void Unity_Sign_float3(float3 In, out float3 Out)
                {
                    Out = sign(In);
                }
                
                void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Normalize_float3(float3 In, out float3 Out)
                {
                    Out = normalize(In);
                }
                
                void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                struct Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8
                {
                    float3 WorldSpaceNormal;
                    float3 WorldSpaceTangent;
                    float3 WorldSpaceBiTangent;
                    float3 AbsoluteWorldSpacePosition;
                    half4 uv0;
                };
                
                void SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float4 Vector4_82674548, float Boolean_9FF42DF6, Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 IN, out float4 XZ_2)
                {
                    float _Property_1ef12cf3201a938993fe6a7951b0e754_Out_0 = Boolean_9FF42DF6;
                    float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
                    float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
                    float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
                    float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
                    float4 _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0 = Vector4_82674548;
                    float _Split_a2e12fa5931da084b2949343a539dfd8_R_1 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[0];
                    float _Split_a2e12fa5931da084b2949343a539dfd8_G_2 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[1];
                    float _Split_a2e12fa5931da084b2949343a539dfd8_B_3 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[2];
                    float _Split_a2e12fa5931da084b2949343a539dfd8_A_4 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[3];
                    float _Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2;
                    Unity_Divide_float(1, _Split_a2e12fa5931da084b2949343a539dfd8_R_1, _Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2);
                    float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
                    Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
                    float2 _Vector2_6845d21872714d889783b0cb707df3e9_Out_0 = float2(_Split_a2e12fa5931da084b2949343a539dfd8_R_1, _Split_a2e12fa5931da084b2949343a539dfd8_G_2);
                    float2 _Vector2_e2e2263627c6098e96a5b5d29350ad03_Out_0 = float2(_Split_a2e12fa5931da084b2949343a539dfd8_B_3, _Split_a2e12fa5931da084b2949343a539dfd8_A_4);
                    float2 _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_6845d21872714d889783b0cb707df3e9_Out_0, _Vector2_e2e2263627c6098e96a5b5d29350ad03_Out_0, _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3);
                    float2 _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3;
                    Unity_Branch_float2(_Property_1ef12cf3201a938993fe6a7951b0e754_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3, _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3);
                    float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3);
                    _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0);
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
                    float2 _Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0 = float2(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4, _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5);
                    float3 _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1;
                    Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1);
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_R_1 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[0];
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_G_2 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[1];
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_B_3 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[2];
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_A_4 = 0;
                    float2 _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0 = float2(_Split_6299d4ddcc4c74828aea40a46fdb896e_G_2, 1);
                    float2 _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2;
                    Unity_Multiply_float(_Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0, _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0, _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2);
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1 = IN.WorldSpaceNormal[0];
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2 = IN.WorldSpaceNormal[1];
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3 = IN.WorldSpaceNormal[2];
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_A_4 = 0;
                    float2 _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0 = float2(_Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1, _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3);
                    float2 _Add_1145b2f896593d80aa864a34e6702562_Out_2;
                    Unity_Add_float2(_Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2, _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0, _Add_1145b2f896593d80aa864a34e6702562_Out_2);
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_R_1 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[0];
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[1];
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_B_3 = 0;
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_A_4 = 0;
                    float _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6, _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2, _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2);
                    float3 _Vector3_433840b555db308b97e9b14b6a957195_Out_0 = float3(_Split_2bc77ca2d17bd78cb2383770ce50b179_R_1, _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2, _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2);
                    float3x3 Transform_c7914cc45a011c89b3f53c55afb51673_tangentTransform_World = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
                    float3 _Transform_c7914cc45a011c89b3f53c55afb51673_Out_1 = TransformWorldToTangent(_Vector3_433840b555db308b97e9b14b6a957195_Out_0.xyz, Transform_c7914cc45a011c89b3f53c55afb51673_tangentTransform_World);
                    float3 _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1;
                    Unity_Normalize_float3(_Transform_c7914cc45a011c89b3f53c55afb51673_Out_1, _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1);
                    float3 _Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3;
                    Unity_Branch_float3(_Property_1ef12cf3201a938993fe6a7951b0e754_Out_0, _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1, (_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.xyz), _Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3);
                    XZ_2 = (float4(_Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3, 1.0));
                }
                
                void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
                {
                    Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
                }
                
                void Unity_Lerp_float(float A, float B, float T, out float Out)
                {
                    Out = lerp(A, B, T);
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7;
                    float3 _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1;
                    SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7, _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1);
                    description.Position = _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float3 BaseColor;
                    float3 NormalTS;
                    float3 Emission;
                    float Metallic;
                    float Smoothness;
                    float Occlusion;
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    float4 _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0 = _BaseTilingOffset;
                    float _Property_7f998178363b4188ba2f07298ef869c1_Out_0 = _BaseUsePlanarUV;
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e;
                    _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.uv0 = IN.uv0;
                    float4 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2);
                    float4 _Property_b83097c58639858680bf43881a95b0af_Out_0 = _BaseColor;
                    float4 _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2;
                    Unity_Multiply_float(_PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2, _Property_b83097c58639858680bf43881a95b0af_Out_0, _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2);
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_4245c3b264047180b5c90a697d6cb278;
                    _PlanarNM_4245c3b264047180b5c90a697d6cb278.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_4245c3b264047180b5c90a697d6cb278.uv0 = IN.uv0;
                    float4 _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseMaskMap, sampler_BaseMaskMap), _BaseMaskMap_TexelSize, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_4245c3b264047180b5c90a697d6cb278, _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2);
                    float _Split_91a015dea8acd38b904ba0935328a5bc_R_1 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[0];
                    float _Split_91a015dea8acd38b904ba0935328a5bc_G_2 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[1];
                    float _Split_91a015dea8acd38b904ba0935328a5bc_B_3 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[2];
                    float _Split_91a015dea8acd38b904ba0935328a5bc_A_4 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[3];
                    float _Property_fbcff1469ebf488394a8a89ddaf0eb2a_Out_0 = _HeightMin;
                    float _Property_9df7a44c8225168683743ac60c0c3c34_Out_0 = _HeightMax;
                    float2 _Vector2_9b1e95888c28bc8893f28c02b87fa448_Out_0 = float2(_Property_fbcff1469ebf488394a8a89ddaf0eb2a_Out_0, _Property_9df7a44c8225168683743ac60c0c3c34_Out_0);
                    float _Property_29ca14fd0b712983a38d63d2dd326e96_Out_0 = _HeightOffset;
                    float2 _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2;
                    Unity_Add_float2(_Vector2_9b1e95888c28bc8893f28c02b87fa448_Out_0, (_Property_29ca14fd0b712983a38d63d2dd326e96_Out_0.xx), _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2);
                    float _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3;
                    Unity_Remap_float(_Split_91a015dea8acd38b904ba0935328a5bc_B_3, float2 (0, 1), _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3);
                    float4 _Property_86a4657df480d48e8d3ad3b036731380_Out_0 = _Base2TilingOffset;
                    float _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0 = _Base2UsePlanarUV;
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4;
                    _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.uv0 = IN.uv0;
                    float4 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_Base2ColorMap, sampler_Base2ColorMap), _Base2ColorMap_TexelSize, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2);
                    float4 _Property_3561b11b899bda8e855826445cf628aa_Out_0 = _Base2Color;
                    float4 _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2;
                    Unity_Multiply_float(_PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2, _Property_3561b11b899bda8e855826445cf628aa_Out_0, _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2);
                    float _Split_85f63081c1b7bc8c83d6bbf4ba6648c5_R_1 = IN.VertexColor[0];
                    float _Split_85f63081c1b7bc8c83d6bbf4ba6648c5_G_2 = IN.VertexColor[1];
                    float _Split_85f63081c1b7bc8c83d6bbf4ba6648c5_B_3 = IN.VertexColor[2];
                    float _Split_85f63081c1b7bc8c83d6bbf4ba6648c5_A_4 = IN.VertexColor[3];
                    float _Property_df2df7bb5cfc3381beee7ec454da7542_Out_0 = _Invert_Layer_Mask;
                    float4 _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0 = SAMPLE_TEXTURE2D(_LayerMask, sampler_LayerMask, IN.uv0.xy);
                    float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.r;
                    float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_G_5 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.g;
                    float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_B_6 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.b;
                    float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_A_7 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.a;
                    float _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1;
                    Unity_OneMinus_float(_SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1);
                    float _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3;
                    Unity_Branch_float(_Property_df2df7bb5cfc3381beee7ec454da7542_Out_0, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1, _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3);
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb;
                    _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.uv0 = IN.uv0;
                    float4 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_Base2MaskMap, sampler_Base2MaskMap), _Base2MaskMap_TexelSize, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2);
                    float _Split_83ec66b648ab6c84848b42686c256cd7_R_1 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[0];
                    float _Split_83ec66b648ab6c84848b42686c256cd7_G_2 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[1];
                    float _Split_83ec66b648ab6c84848b42686c256cd7_B_3 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[2];
                    float _Split_83ec66b648ab6c84848b42686c256cd7_A_4 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[3];
                    float _Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0 = _HeightMin2;
                    float _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0 = _HeightMax2;
                    float2 _Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0 = float2(_Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0, _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0);
                    float _Property_151ae2702b614585af2000f0a812960f_Out_0 = _HeightOffset2;
                    float2 _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2;
                    Unity_Add_float2(_Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0, (_Property_151ae2702b614585af2000f0a812960f_Out_0.xx), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2);
                    float _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3;
                    Unity_Remap_float(_Split_83ec66b648ab6c84848b42686c256cd7_B_3, float2 (0, 1), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3);
                    float _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2;
                    Unity_Multiply_float(_Branch_af0c5e511241ce8eae748ae487df50fa_Out_3, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2);
                    float _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2;
                    Unity_Multiply_float(_Split_85f63081c1b7bc8c83d6bbf4ba6648c5_B_3, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2);
                    float _Property_818c8af4b930138e81034c886614171d_Out_0 = _Height_Transition;
                    Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_7501025b3a60738a9a9d362e35a9ab48;
                    float3 _HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1;
                    SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135((_Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2.xyz), _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3, (_Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2.xyz), _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Property_818c8af4b930138e81034c886614171d_Out_0, _HeightBlend_7501025b3a60738a9a9d362e35a9ab48, _HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1);
                    float4 _Property_696647de24586381a15debb755f8f569_Out_0 = _WetColor;
                    float3 _Multiply_dec52e2895a185829e24dfeaeeba8184_Out_2;
                    Unity_Multiply_float((_Property_696647de24586381a15debb755f8f569_Out_0.xyz), _HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1, _Multiply_dec52e2895a185829e24dfeaeeba8184_Out_2);
                    float _OneMinus_0b9ce7d9f924bf8193dc9bdd9b2268e1_Out_1;
                    Unity_OneMinus_float(_Split_85f63081c1b7bc8c83d6bbf4ba6648c5_R_1, _OneMinus_0b9ce7d9f924bf8193dc9bdd9b2268e1_Out_1);
                    float3 _Lerp_7a7642d5ea869889935d4d1799cc7ad3_Out_3;
                    Unity_Lerp_float3(_HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1, _Multiply_dec52e2895a185829e24dfeaeeba8184_Out_2, (_OneMinus_0b9ce7d9f924bf8193dc9bdd9b2268e1_Out_1.xxx), _Lerp_7a7642d5ea869889935d4d1799cc7ad3_Out_3);
                    Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8;
                    _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceTangent = IN.WorldSpaceTangent;
                    _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                    _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.uv0 = IN.uv0;
                    float4 _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2;
                    SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_ARGS(_BaseNormalMap, sampler_BaseNormalMap), _BaseNormalMap_TexelSize, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8, _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2);
                    float _Property_d4b0759cf4647e81be065ec1465ce2b4_Out_0 = _BaseNormalScale;
                    float3 _NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2;
                    Unity_NormalStrength_float((_PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2.xyz), _Property_d4b0759cf4647e81be065ec1465ce2b4_Out_0, _NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2);
                    Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf;
                    _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceTangent = IN.WorldSpaceTangent;
                    _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                    _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.uv0 = IN.uv0;
                    float4 _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2;
                    SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_ARGS(_Base2NormalMap, sampler_Base2NormalMap), _Base2NormalMap_TexelSize, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf, _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2);
                    float _Property_8c31443b776727819a663c7ddce79064_Out_0 = _Base2NormalScale;
                    float3 _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2;
                    Unity_NormalStrength_float((_PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2.xyz), _Property_8c31443b776727819a663c7ddce79064_Out_0, _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2);
                    Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_7c09d97625efce898e21b66cd039be8b;
                    float3 _HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1;
                    SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(_NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3, _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Property_818c8af4b930138e81034c886614171d_Out_0, _HeightBlend_7c09d97625efce898e21b66cd039be8b, _HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1);
                    float _Property_afd0f3561038ef8487e614f350d364dd_Out_0 = _BaseMetallic;
                    float _Multiply_154e0f89b19c8e86926222afb13691e3_Out_2;
                    Unity_Multiply_float(_Split_91a015dea8acd38b904ba0935328a5bc_R_1, _Property_afd0f3561038ef8487e614f350d364dd_Out_0, _Multiply_154e0f89b19c8e86926222afb13691e3_Out_2);
                    float _Property_b82ce26778f44c8fa3510d1a8ed92d0d_Out_0 = _BaseAORemapMin;
                    float _Property_9d07c7a09a85da809f1d4661406e0888_Out_0 = _BaseAORemapMax;
                    float2 _Vector2_10162c774de2a7838426399cfe98be82_Out_0 = float2(_Property_b82ce26778f44c8fa3510d1a8ed92d0d_Out_0, _Property_9d07c7a09a85da809f1d4661406e0888_Out_0);
                    float _Remap_c45fda31db668c81a9e89e11297ec993_Out_3;
                    Unity_Remap_float(_Split_91a015dea8acd38b904ba0935328a5bc_G_2, float2 (0, 1), _Vector2_10162c774de2a7838426399cfe98be82_Out_0, _Remap_c45fda31db668c81a9e89e11297ec993_Out_3);
                    float _Property_04a7bb2753456b8293b3e46e346b646e_Out_0 = _BaseSmoothnessRemapMin;
                    float _Property_75c8631fc908bb8ba8542d2e70d18cbf_Out_0 = _BaseSmoothnessRemapMax;
                    float2 _Vector2_b2e1a3c487cdf88f9b5992b831ba24d6_Out_0 = float2(_Property_04a7bb2753456b8293b3e46e346b646e_Out_0, _Property_75c8631fc908bb8ba8542d2e70d18cbf_Out_0);
                    float _Remap_65ca5af95590f88da70777476b6efd40_Out_3;
                    Unity_Remap_float(_Split_91a015dea8acd38b904ba0935328a5bc_A_4, float2 (0, 1), _Vector2_b2e1a3c487cdf88f9b5992b831ba24d6_Out_0, _Remap_65ca5af95590f88da70777476b6efd40_Out_3);
                    float3 _Vector3_28c1e2dadb10138a9799d970043db9b0_Out_0 = float3(_Multiply_154e0f89b19c8e86926222afb13691e3_Out_2, _Remap_c45fda31db668c81a9e89e11297ec993_Out_3, _Remap_65ca5af95590f88da70777476b6efd40_Out_3);
                    float _Property_4ead43cc6d37b68eb268dd80c3a561e9_Out_0 = _Base2Metallic;
                    float _Multiply_eef7838a4634498b9cf12d1bee89d853_Out_2;
                    Unity_Multiply_float(_Split_83ec66b648ab6c84848b42686c256cd7_R_1, _Property_4ead43cc6d37b68eb268dd80c3a561e9_Out_0, _Multiply_eef7838a4634498b9cf12d1bee89d853_Out_2);
                    float _Property_e1ed9fe432388887abb17b07dcc5ca6b_Out_0 = _Base2AORemapMin;
                    float _Property_cb0cf7882dcbcf88989a12f73fb7c917_Out_0 = _Base2AORemapMax;
                    float2 _Vector2_2d74d82ae79d5681a097c2e3ce20c913_Out_0 = float2(_Property_e1ed9fe432388887abb17b07dcc5ca6b_Out_0, _Property_cb0cf7882dcbcf88989a12f73fb7c917_Out_0);
                    float _Remap_dcd2e2871e334281a15cdd1da6103c7f_Out_3;
                    Unity_Remap_float(_Split_83ec66b648ab6c84848b42686c256cd7_G_2, float2 (0, 1), _Vector2_2d74d82ae79d5681a097c2e3ce20c913_Out_0, _Remap_dcd2e2871e334281a15cdd1da6103c7f_Out_3);
                    float _Property_159cd47513de4f85a992da1f43f77c51_Out_0 = _Base2SmoothnessRemapMin;
                    float _Property_b1f3c7061cf84380b1a0ffc2c5f770db_Out_0 = _Base2SmoothnessRemapMax;
                    float2 _Vector2_eb0fcc98def54d83abe1cfec60457b78_Out_0 = float2(_Property_159cd47513de4f85a992da1f43f77c51_Out_0, _Property_b1f3c7061cf84380b1a0ffc2c5f770db_Out_0);
                    float _Remap_1214803bb0f7c387adc088fb938f7971_Out_3;
                    Unity_Remap_float(_Split_83ec66b648ab6c84848b42686c256cd7_A_4, float2 (0, 1), _Vector2_eb0fcc98def54d83abe1cfec60457b78_Out_0, _Remap_1214803bb0f7c387adc088fb938f7971_Out_3);
                    float3 _Vector3_ddb5452f73a0dc819b57dbe981a5f4e7_Out_0 = float3(_Multiply_eef7838a4634498b9cf12d1bee89d853_Out_2, _Remap_dcd2e2871e334281a15cdd1da6103c7f_Out_3, _Remap_1214803bb0f7c387adc088fb938f7971_Out_3);
                    Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_3ef23bc9c463ea8f91d2c1bc27c32dff;
                    float3 _HeightBlend_3ef23bc9c463ea8f91d2c1bc27c32dff_OutVector4_1;
                    SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(_Vector3_28c1e2dadb10138a9799d970043db9b0_Out_0, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3, _Vector3_ddb5452f73a0dc819b57dbe981a5f4e7_Out_0, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Property_818c8af4b930138e81034c886614171d_Out_0, _HeightBlend_3ef23bc9c463ea8f91d2c1bc27c32dff, _HeightBlend_3ef23bc9c463ea8f91d2c1bc27c32dff_OutVector4_1);
                    float _Split_93a6a2f8a95a1b80bea53b3c9628de7b_R_1 = _HeightBlend_3ef23bc9c463ea8f91d2c1bc27c32dff_OutVector4_1[0];
                    float _Split_93a6a2f8a95a1b80bea53b3c9628de7b_G_2 = _HeightBlend_3ef23bc9c463ea8f91d2c1bc27c32dff_OutVector4_1[1];
                    float _Split_93a6a2f8a95a1b80bea53b3c9628de7b_B_3 = _HeightBlend_3ef23bc9c463ea8f91d2c1bc27c32dff_OutVector4_1[2];
                    float _Split_93a6a2f8a95a1b80bea53b3c9628de7b_A_4 = 0;
                    float _Property_c517a33d4cfc53868e1596c4fe2fb681_Out_0 = _WetSmoothness;
                    float _Lerp_3c369133aa2f1781a71532efbad4b64d_Out_3;
                    Unity_Lerp_float(_Split_93a6a2f8a95a1b80bea53b3c9628de7b_B_3, _Property_c517a33d4cfc53868e1596c4fe2fb681_Out_0, _OneMinus_0b9ce7d9f924bf8193dc9bdd9b2268e1_Out_1, _Lerp_3c369133aa2f1781a71532efbad4b64d_Out_3);
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_R_1 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[0];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_G_2 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[1];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_B_3 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[2];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[3];
                    float _Property_8bc98dd454a5508b9864a6ba09772356_Out_0 = _AlphaCutoff;
                    surface.BaseColor = _Lerp_7a7642d5ea869889935d4d1799cc7ad3_Out_3;
                    surface.NormalTS = _HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1;
                    surface.Emission = float3(0, 0, 0);
                    surface.Metallic = _Split_93a6a2f8a95a1b80bea53b3c9628de7b_R_1;
                    surface.Smoothness = _Lerp_3c369133aa2f1781a71532efbad4b64d_Out_3;
                    surface.Occlusion = _Split_93a6a2f8a95a1b80bea53b3c9628de7b_G_2;
                    surface.Alpha = _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4;
                    surface.AlphaClipThreshold = _Property_8bc98dd454a5508b9864a6ba09772356_Out_0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.ObjectSpacePosition =         input.positionOS;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                	// must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
                	float3 unnormalizedNormalWS = input.normalWS;
                    const float renormFactor = 1.0 / length(unnormalizedNormalWS);
                
                	// use bitangent on the fly like in hdrp
                	// IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
                    float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
                	float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
                
                    output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
                    output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                
                	// to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
                	// This is explained in section 2.2 in "surface gradient based bump mapping framework"
                    output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
                	output.WorldSpaceBiTangent =         renormFactor*bitang;
                
                    output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
                    output.uv0 =                         input.texCoord0;
                    output.VertexColor =                 input.color;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRForwardPass.hlsl"
    
                ENDHLSL
            }
            Pass
            {
                Name "ShadowCaster"
                Tags
                {
                    "LightMode" = "ShadowCaster"
                }
    
                // Render State
                Cull Back
                Blend One Zero
                ZTest LEqual
                ZWrite On
                ColorMask 0
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 2.0
                #pragma only_renderers gles gles3 glcore
                #pragma multi_compile_instancing
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                // PassKeywords: <None>
                // GraphKeywords: <None>
    
                // Defines
                #define _AlphaClip 1
                #define _NORMALMAP 1
                #define _NORMAL_DROPOFF_TS 1
                #define ATTRIBUTES_NEED_NORMAL
                #define ATTRIBUTES_NEED_TANGENT
                #define ATTRIBUTES_NEED_TEXCOORD0
                #define VARYINGS_NEED_POSITION_WS
                #define VARYINGS_NEED_TEXCOORD0
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_SHADOWCASTER
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    float3 positionOS : POSITION;
                    float3 normalOS : NORMAL;
                    float4 tangentOS : TANGENT;
                    float4 uv0 : TEXCOORD0;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                };
                struct Varyings
                {
                    float4 positionCS : SV_POSITION;
                    float3 positionWS;
                    float4 texCoord0;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    float3 AbsoluteWorldSpacePosition;
                    float4 uv0;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 ObjectSpacePosition;
                };
                struct PackedVaryings
                {
                    float4 positionCS : SV_POSITION;
                    float3 interp0 : TEXCOORD0;
                    float4 interp1 : TEXCOORD1;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
    
                PackedVaryings PackVaryings (Varyings input)
                {
                    PackedVaryings output;
                    output.positionCS = input.positionCS;
                    output.interp0.xyz =  input.positionWS;
                    output.interp1.xyzw =  input.texCoord0;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
                Varyings UnpackVaryings (PackedVaryings input)
                {
                    Varyings output;
                    output.positionCS = input.positionCS;
                    output.positionWS = input.interp0.xyz;
                    output.texCoord0 = input.interp1.xyzw;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _AlphaCutoff;
                float4 _BaseColor;
                float4 _BaseColorMap_TexelSize;
                float _BaseUsePlanarUV;
                float4 _BaseTilingOffset;
                float4 _BaseNormalMap_TexelSize;
                float _BaseNormalScale;
                float4 _BaseMaskMap_TexelSize;
                float _BaseMetallic;
                float _BaseAORemapMin;
                float _BaseAORemapMax;
                float _BaseSmoothnessRemapMin;
                float _BaseSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float _Invert_Layer_Mask;
                float _Height_Transition;
                float _HeightMin;
                float _HeightMax;
                float _HeightOffset;
                float _HeightMin2;
                float _HeightMax2;
                float _HeightOffset2;
                float4 _Base2Color;
                float4 _Base2ColorMap_TexelSize;
                float4 _Base2TilingOffset;
                float _Base2UsePlanarUV;
                float4 _Base2NormalMap_TexelSize;
                float _Base2NormalScale;
                float4 _Base2MaskMap_TexelSize;
                float _Base2Metallic;
                float _Base2SmoothnessRemapMin;
                float _Base2SmoothnessRemapMax;
                float _Base2AORemapMin;
                float _Base2AORemapMax;
                float4 _WetColor;
                float _WetSmoothness;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_BaseColorMap);
                SAMPLER(sampler_BaseColorMap);
                TEXTURE2D(_BaseNormalMap);
                SAMPLER(sampler_BaseNormalMap);
                TEXTURE2D(_BaseMaskMap);
                SAMPLER(sampler_BaseMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_Base2ColorMap);
                SAMPLER(sampler_Base2ColorMap);
                TEXTURE2D(_Base2NormalMap);
                SAMPLER(sampler_Base2NormalMap);
                TEXTURE2D(_Base2MaskMap);
                SAMPLER(sampler_Base2MaskMap);
                SAMPLER(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 6a9c7522090e0644e0cdf14d6feac267
                #include "Assets/NatureManufacture Assets/Object Shaders/NM_Object_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b
                {
                };
                
                void SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(float3 Vector3_314C8600, Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                {
                    Out = A * B;
                }
                
                void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                {
                    Out = UV * Tiling + Offset;
                }
                
                void Unity_Branch_float2(float Predicate, float2 True, float2 False, out float2 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                struct Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6
                {
                    float3 AbsoluteWorldSpacePosition;
                    half4 uv0;
                };
                
                void SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float4 Vector4_2EBA7A3B, float Boolean_7ABB9909, Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 IN, out float4 XZ_2)
                {
                    float _Property_30834f691775a0898a45b1c868520436_Out_0 = Boolean_7ABB9909;
                    float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
                    float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
                    float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
                    float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
                    float4 _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0 = Vector4_2EBA7A3B;
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[0];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[1];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[2];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[3];
                    float _Divide_e64179199923c58289b6aa94ea6c9178_Out_2;
                    Unity_Divide_float(1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Divide_e64179199923c58289b6aa94ea6c9178_Out_2);
                    float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
                    Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_e64179199923c58289b6aa94ea6c9178_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
                    float2 _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2);
                    float2 _Vector2_f8d75f54e7705083bbec539a60185577_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4);
                    float2 _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0, _Vector2_f8d75f54e7705083bbec539a60185577_Out_0, _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3);
                    float2 _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3;
                    Unity_Branch_float2(_Property_30834f691775a0898a45b1c868520436_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
                    float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
                    XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7;
                    float3 _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1;
                    SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7, _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1);
                    description.Position = _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    float4 _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0 = _BaseTilingOffset;
                    float _Property_7f998178363b4188ba2f07298ef869c1_Out_0 = _BaseUsePlanarUV;
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e;
                    _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.uv0 = IN.uv0;
                    float4 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2);
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_R_1 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[0];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_G_2 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[1];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_B_3 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[2];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[3];
                    float _Property_8bc98dd454a5508b9864a6ba09772356_Out_0 = _AlphaCutoff;
                    surface.Alpha = _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4;
                    surface.AlphaClipThreshold = _Property_8bc98dd454a5508b9864a6ba09772356_Out_0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.ObjectSpacePosition =         input.positionOS;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                
                
                
                
                    output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
                    output.uv0 =                         input.texCoord0;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShadowCasterPass.hlsl"
    
                ENDHLSL
            }
            Pass
            {
                Name "DepthOnly"
                Tags
                {
                    "LightMode" = "DepthOnly"
                }
    
                // Render State
                Cull Back
                Blend One Zero
                ZTest LEqual
                ZWrite On
                ColorMask 0
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 2.0
                #pragma only_renderers gles gles3 glcore
                #pragma multi_compile_instancing
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                // PassKeywords: <None>
                // GraphKeywords: <None>
    
                // Defines
                #define _AlphaClip 1
                #define _NORMALMAP 1
                #define _NORMAL_DROPOFF_TS 1
                #define ATTRIBUTES_NEED_NORMAL
                #define ATTRIBUTES_NEED_TANGENT
                #define ATTRIBUTES_NEED_TEXCOORD0
                #define VARYINGS_NEED_POSITION_WS
                #define VARYINGS_NEED_TEXCOORD0
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_DEPTHONLY
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    float3 positionOS : POSITION;
                    float3 normalOS : NORMAL;
                    float4 tangentOS : TANGENT;
                    float4 uv0 : TEXCOORD0;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                };
                struct Varyings
                {
                    float4 positionCS : SV_POSITION;
                    float3 positionWS;
                    float4 texCoord0;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    float3 AbsoluteWorldSpacePosition;
                    float4 uv0;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 ObjectSpacePosition;
                };
                struct PackedVaryings
                {
                    float4 positionCS : SV_POSITION;
                    float3 interp0 : TEXCOORD0;
                    float4 interp1 : TEXCOORD1;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
    
                PackedVaryings PackVaryings (Varyings input)
                {
                    PackedVaryings output;
                    output.positionCS = input.positionCS;
                    output.interp0.xyz =  input.positionWS;
                    output.interp1.xyzw =  input.texCoord0;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
                Varyings UnpackVaryings (PackedVaryings input)
                {
                    Varyings output;
                    output.positionCS = input.positionCS;
                    output.positionWS = input.interp0.xyz;
                    output.texCoord0 = input.interp1.xyzw;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _AlphaCutoff;
                float4 _BaseColor;
                float4 _BaseColorMap_TexelSize;
                float _BaseUsePlanarUV;
                float4 _BaseTilingOffset;
                float4 _BaseNormalMap_TexelSize;
                float _BaseNormalScale;
                float4 _BaseMaskMap_TexelSize;
                float _BaseMetallic;
                float _BaseAORemapMin;
                float _BaseAORemapMax;
                float _BaseSmoothnessRemapMin;
                float _BaseSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float _Invert_Layer_Mask;
                float _Height_Transition;
                float _HeightMin;
                float _HeightMax;
                float _HeightOffset;
                float _HeightMin2;
                float _HeightMax2;
                float _HeightOffset2;
                float4 _Base2Color;
                float4 _Base2ColorMap_TexelSize;
                float4 _Base2TilingOffset;
                float _Base2UsePlanarUV;
                float4 _Base2NormalMap_TexelSize;
                float _Base2NormalScale;
                float4 _Base2MaskMap_TexelSize;
                float _Base2Metallic;
                float _Base2SmoothnessRemapMin;
                float _Base2SmoothnessRemapMax;
                float _Base2AORemapMin;
                float _Base2AORemapMax;
                float4 _WetColor;
                float _WetSmoothness;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_BaseColorMap);
                SAMPLER(sampler_BaseColorMap);
                TEXTURE2D(_BaseNormalMap);
                SAMPLER(sampler_BaseNormalMap);
                TEXTURE2D(_BaseMaskMap);
                SAMPLER(sampler_BaseMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_Base2ColorMap);
                SAMPLER(sampler_Base2ColorMap);
                TEXTURE2D(_Base2NormalMap);
                SAMPLER(sampler_Base2NormalMap);
                TEXTURE2D(_Base2MaskMap);
                SAMPLER(sampler_Base2MaskMap);
                SAMPLER(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 6a9c7522090e0644e0cdf14d6feac267
                #include "Assets/NatureManufacture Assets/Object Shaders/NM_Object_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b
                {
                };
                
                void SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(float3 Vector3_314C8600, Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                {
                    Out = A * B;
                }
                
                void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                {
                    Out = UV * Tiling + Offset;
                }
                
                void Unity_Branch_float2(float Predicate, float2 True, float2 False, out float2 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                struct Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6
                {
                    float3 AbsoluteWorldSpacePosition;
                    half4 uv0;
                };
                
                void SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float4 Vector4_2EBA7A3B, float Boolean_7ABB9909, Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 IN, out float4 XZ_2)
                {
                    float _Property_30834f691775a0898a45b1c868520436_Out_0 = Boolean_7ABB9909;
                    float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
                    float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
                    float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
                    float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
                    float4 _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0 = Vector4_2EBA7A3B;
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[0];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[1];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[2];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[3];
                    float _Divide_e64179199923c58289b6aa94ea6c9178_Out_2;
                    Unity_Divide_float(1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Divide_e64179199923c58289b6aa94ea6c9178_Out_2);
                    float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
                    Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_e64179199923c58289b6aa94ea6c9178_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
                    float2 _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2);
                    float2 _Vector2_f8d75f54e7705083bbec539a60185577_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4);
                    float2 _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0, _Vector2_f8d75f54e7705083bbec539a60185577_Out_0, _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3);
                    float2 _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3;
                    Unity_Branch_float2(_Property_30834f691775a0898a45b1c868520436_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
                    float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
                    XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7;
                    float3 _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1;
                    SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7, _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1);
                    description.Position = _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    float4 _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0 = _BaseTilingOffset;
                    float _Property_7f998178363b4188ba2f07298ef869c1_Out_0 = _BaseUsePlanarUV;
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e;
                    _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.uv0 = IN.uv0;
                    float4 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2);
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_R_1 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[0];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_G_2 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[1];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_B_3 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[2];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[3];
                    float _Property_8bc98dd454a5508b9864a6ba09772356_Out_0 = _AlphaCutoff;
                    surface.Alpha = _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4;
                    surface.AlphaClipThreshold = _Property_8bc98dd454a5508b9864a6ba09772356_Out_0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.ObjectSpacePosition =         input.positionOS;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                
                
                
                
                    output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
                    output.uv0 =                         input.texCoord0;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthOnlyPass.hlsl"
    
                ENDHLSL
            }
            Pass
            {
                Name "DepthNormals"
                Tags
                {
                    "LightMode" = "DepthNormals"
                }
    
                // Render State
                Cull Back
                Blend One Zero
                ZTest LEqual
                ZWrite On
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 2.0
                #pragma only_renderers gles gles3 glcore
                #pragma multi_compile_instancing
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                // PassKeywords: <None>
                // GraphKeywords: <None>
    
                // Defines
                #define _AlphaClip 1
                #define _NORMALMAP 1
                #define _NORMAL_DROPOFF_TS 1
                #define ATTRIBUTES_NEED_NORMAL
                #define ATTRIBUTES_NEED_TANGENT
                #define ATTRIBUTES_NEED_TEXCOORD0
                #define ATTRIBUTES_NEED_TEXCOORD1
                #define ATTRIBUTES_NEED_COLOR
                #define VARYINGS_NEED_POSITION_WS
                #define VARYINGS_NEED_NORMAL_WS
                #define VARYINGS_NEED_TANGENT_WS
                #define VARYINGS_NEED_TEXCOORD0
                #define VARYINGS_NEED_COLOR
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_DEPTHNORMALSONLY
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    float3 positionOS : POSITION;
                    float3 normalOS : NORMAL;
                    float4 tangentOS : TANGENT;
                    float4 uv0 : TEXCOORD0;
                    float4 uv1 : TEXCOORD1;
                    float4 color : COLOR;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                };
                struct Varyings
                {
                    float4 positionCS : SV_POSITION;
                    float3 positionWS;
                    float3 normalWS;
                    float4 tangentWS;
                    float4 texCoord0;
                    float4 color;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    float3 WorldSpaceNormal;
                    float3 TangentSpaceNormal;
                    float3 WorldSpaceTangent;
                    float3 WorldSpaceBiTangent;
                    float3 AbsoluteWorldSpacePosition;
                    float4 uv0;
                    float4 VertexColor;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 ObjectSpacePosition;
                };
                struct PackedVaryings
                {
                    float4 positionCS : SV_POSITION;
                    float3 interp0 : TEXCOORD0;
                    float3 interp1 : TEXCOORD1;
                    float4 interp2 : TEXCOORD2;
                    float4 interp3 : TEXCOORD3;
                    float4 interp4 : TEXCOORD4;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
    
                PackedVaryings PackVaryings (Varyings input)
                {
                    PackedVaryings output;
                    output.positionCS = input.positionCS;
                    output.interp0.xyz =  input.positionWS;
                    output.interp1.xyz =  input.normalWS;
                    output.interp2.xyzw =  input.tangentWS;
                    output.interp3.xyzw =  input.texCoord0;
                    output.interp4.xyzw =  input.color;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
                Varyings UnpackVaryings (PackedVaryings input)
                {
                    Varyings output;
                    output.positionCS = input.positionCS;
                    output.positionWS = input.interp0.xyz;
                    output.normalWS = input.interp1.xyz;
                    output.tangentWS = input.interp2.xyzw;
                    output.texCoord0 = input.interp3.xyzw;
                    output.color = input.interp4.xyzw;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _AlphaCutoff;
                float4 _BaseColor;
                float4 _BaseColorMap_TexelSize;
                float _BaseUsePlanarUV;
                float4 _BaseTilingOffset;
                float4 _BaseNormalMap_TexelSize;
                float _BaseNormalScale;
                float4 _BaseMaskMap_TexelSize;
                float _BaseMetallic;
                float _BaseAORemapMin;
                float _BaseAORemapMax;
                float _BaseSmoothnessRemapMin;
                float _BaseSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float _Invert_Layer_Mask;
                float _Height_Transition;
                float _HeightMin;
                float _HeightMax;
                float _HeightOffset;
                float _HeightMin2;
                float _HeightMax2;
                float _HeightOffset2;
                float4 _Base2Color;
                float4 _Base2ColorMap_TexelSize;
                float4 _Base2TilingOffset;
                float _Base2UsePlanarUV;
                float4 _Base2NormalMap_TexelSize;
                float _Base2NormalScale;
                float4 _Base2MaskMap_TexelSize;
                float _Base2Metallic;
                float _Base2SmoothnessRemapMin;
                float _Base2SmoothnessRemapMax;
                float _Base2AORemapMin;
                float _Base2AORemapMax;
                float4 _WetColor;
                float _WetSmoothness;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_BaseColorMap);
                SAMPLER(sampler_BaseColorMap);
                TEXTURE2D(_BaseNormalMap);
                SAMPLER(sampler_BaseNormalMap);
                TEXTURE2D(_BaseMaskMap);
                SAMPLER(sampler_BaseMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_Base2ColorMap);
                SAMPLER(sampler_Base2ColorMap);
                TEXTURE2D(_Base2NormalMap);
                SAMPLER(sampler_Base2NormalMap);
                TEXTURE2D(_Base2MaskMap);
                SAMPLER(sampler_Base2MaskMap);
                SAMPLER(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 6a9c7522090e0644e0cdf14d6feac267
                #include "Assets/NatureManufacture Assets/Object Shaders/NM_Object_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b
                {
                };
                
                void SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(float3 Vector3_314C8600, Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                {
                    Out = A * B;
                }
                
                void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                {
                    Out = UV * Tiling + Offset;
                }
                
                void Unity_Branch_float2(float Predicate, float2 True, float2 False, out float2 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Sign_float3(float3 In, out float3 Out)
                {
                    Out = sign(In);
                }
                
                void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Add_float2(float2 A, float2 B, out float2 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Normalize_float3(float3 In, out float3 Out)
                {
                    Out = normalize(In);
                }
                
                void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                struct Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8
                {
                    float3 WorldSpaceNormal;
                    float3 WorldSpaceTangent;
                    float3 WorldSpaceBiTangent;
                    float3 AbsoluteWorldSpacePosition;
                    half4 uv0;
                };
                
                void SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float4 Vector4_82674548, float Boolean_9FF42DF6, Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 IN, out float4 XZ_2)
                {
                    float _Property_1ef12cf3201a938993fe6a7951b0e754_Out_0 = Boolean_9FF42DF6;
                    float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
                    float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
                    float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
                    float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
                    float4 _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0 = Vector4_82674548;
                    float _Split_a2e12fa5931da084b2949343a539dfd8_R_1 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[0];
                    float _Split_a2e12fa5931da084b2949343a539dfd8_G_2 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[1];
                    float _Split_a2e12fa5931da084b2949343a539dfd8_B_3 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[2];
                    float _Split_a2e12fa5931da084b2949343a539dfd8_A_4 = _Property_3fa1d6f912feb481ba60f2e55e62e746_Out_0[3];
                    float _Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2;
                    Unity_Divide_float(1, _Split_a2e12fa5931da084b2949343a539dfd8_R_1, _Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2);
                    float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
                    Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_c36b770dfaa0bb8f85ab27da5fd794f0_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
                    float2 _Vector2_6845d21872714d889783b0cb707df3e9_Out_0 = float2(_Split_a2e12fa5931da084b2949343a539dfd8_R_1, _Split_a2e12fa5931da084b2949343a539dfd8_G_2);
                    float2 _Vector2_e2e2263627c6098e96a5b5d29350ad03_Out_0 = float2(_Split_a2e12fa5931da084b2949343a539dfd8_B_3, _Split_a2e12fa5931da084b2949343a539dfd8_A_4);
                    float2 _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_6845d21872714d889783b0cb707df3e9_Out_0, _Vector2_e2e2263627c6098e96a5b5d29350ad03_Out_0, _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3);
                    float2 _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3;
                    Unity_Branch_float2(_Property_1ef12cf3201a938993fe6a7951b0e754_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_17582d056c0b8a8dab1017d37497fe59_Out_3, _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3);
                    float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Branch_1e152f3aac57448f8518bf2852c000c3_Out_3);
                    _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0);
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
                    float2 _Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0 = float2(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4, _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5);
                    float3 _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1;
                    Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1);
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_R_1 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[0];
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_G_2 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[1];
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_B_3 = _Sign_3a6ebf59931cf08cb0482e0144ddac24_Out_1[2];
                    float _Split_6299d4ddcc4c74828aea40a46fdb896e_A_4 = 0;
                    float2 _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0 = float2(_Split_6299d4ddcc4c74828aea40a46fdb896e_G_2, 1);
                    float2 _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2;
                    Unity_Multiply_float(_Vector2_ad6bd100e273d78fa409a30a77bfa2cc_Out_0, _Vector2_b76cb1842101e58b9e636d49b075c612_Out_0, _Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2);
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1 = IN.WorldSpaceNormal[0];
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2 = IN.WorldSpaceNormal[1];
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3 = IN.WorldSpaceNormal[2];
                    float _Split_5ed44bf2eca0868f81eb18100f49d1fa_A_4 = 0;
                    float2 _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0 = float2(_Split_5ed44bf2eca0868f81eb18100f49d1fa_R_1, _Split_5ed44bf2eca0868f81eb18100f49d1fa_B_3);
                    float2 _Add_1145b2f896593d80aa864a34e6702562_Out_2;
                    Unity_Add_float2(_Multiply_31e8db88ee20c985a9850d1a58f3282b_Out_2, _Vector2_70e5837843f28b8b9d64cada3697bd5a_Out_0, _Add_1145b2f896593d80aa864a34e6702562_Out_2);
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_R_1 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[0];
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2 = _Add_1145b2f896593d80aa864a34e6702562_Out_2[1];
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_B_3 = 0;
                    float _Split_2bc77ca2d17bd78cb2383770ce50b179_A_4 = 0;
                    float _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2;
                    Unity_Multiply_float(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6, _Split_5ed44bf2eca0868f81eb18100f49d1fa_G_2, _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2);
                    float3 _Vector3_433840b555db308b97e9b14b6a957195_Out_0 = float3(_Split_2bc77ca2d17bd78cb2383770ce50b179_R_1, _Multiply_ab12aea87465a78eaf7fc66c2598d266_Out_2, _Split_2bc77ca2d17bd78cb2383770ce50b179_G_2);
                    float3x3 Transform_c7914cc45a011c89b3f53c55afb51673_tangentTransform_World = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
                    float3 _Transform_c7914cc45a011c89b3f53c55afb51673_Out_1 = TransformWorldToTangent(_Vector3_433840b555db308b97e9b14b6a957195_Out_0.xyz, Transform_c7914cc45a011c89b3f53c55afb51673_tangentTransform_World);
                    float3 _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1;
                    Unity_Normalize_float3(_Transform_c7914cc45a011c89b3f53c55afb51673_Out_1, _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1);
                    float3 _Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3;
                    Unity_Branch_float3(_Property_1ef12cf3201a938993fe6a7951b0e754_Out_0, _Normalize_09bf8a2bd0a4d38e8b97d5c674f79b44_Out_1, (_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.xyz), _Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3);
                    XZ_2 = (float4(_Branch_9eadf909a90f2f80880f8c56ecc2a91f_Out_3, 1.0));
                }
                
                void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
                {
                    Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
                }
                
                struct Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6
                {
                    float3 AbsoluteWorldSpacePosition;
                    half4 uv0;
                };
                
                void SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float4 Vector4_2EBA7A3B, float Boolean_7ABB9909, Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 IN, out float4 XZ_2)
                {
                    float _Property_30834f691775a0898a45b1c868520436_Out_0 = Boolean_7ABB9909;
                    float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
                    float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
                    float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
                    float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
                    float4 _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0 = Vector4_2EBA7A3B;
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[0];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[1];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[2];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[3];
                    float _Divide_e64179199923c58289b6aa94ea6c9178_Out_2;
                    Unity_Divide_float(1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Divide_e64179199923c58289b6aa94ea6c9178_Out_2);
                    float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
                    Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_e64179199923c58289b6aa94ea6c9178_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
                    float2 _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2);
                    float2 _Vector2_f8d75f54e7705083bbec539a60185577_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4);
                    float2 _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0, _Vector2_f8d75f54e7705083bbec539a60185577_Out_0, _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3);
                    float2 _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3;
                    Unity_Branch_float2(_Property_30834f691775a0898a45b1c868520436_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
                    float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
                    XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
                }
                
                void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
                {
                    Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
                }
                
                void Unity_OneMinus_float(float In, out float Out)
                {
                    Out = 1 - In;
                }
                
                void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Maximum_float(float A, float B, out float Out)
                {
                    Out = max(A, B);
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Add_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A / B;
                }
                
                struct Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135
                {
                };
                
                void SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(float3 Vector3_88EEBB5E, float Vector1_DA0A37FA, float3 Vector3_79AA92F, float Vector1_F7E83F1E, float Vector1_1C9222A6, Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 IN, out float3 OutVector4_1)
                {
                    float3 _Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0 = Vector3_88EEBB5E;
                    float _Property_14119cc7eaf4128f991283d47cf72d85_Out_0 = Vector1_DA0A37FA;
                    float _Property_48af0ad45e3f7f82932b938695d21391_Out_0 = Vector1_DA0A37FA;
                    float _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0 = Vector1_F7E83F1E;
                    float _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2;
                    Unity_Maximum_float(_Property_48af0ad45e3f7f82932b938695d21391_Out_0, _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0, _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2);
                    float _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0 = Vector1_1C9222A6;
                    float _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2;
                    Unity_Subtract_float(_Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2, _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2);
                    float _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2;
                    Unity_Subtract_float(_Property_14119cc7eaf4128f991283d47cf72d85_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2);
                    float _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2;
                    Unity_Maximum_float(_Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2, 0, _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2);
                    float3 _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2;
                    Unity_Multiply_float(_Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0, (_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2.xxx), _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2);
                    float3 _Property_c7292b3b08585f8c8670172b9a220bf0_Out_0 = Vector3_79AA92F;
                    float _Property_5e920479576fad83ba1947728dcceab4_Out_0 = Vector1_F7E83F1E;
                    float _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2;
                    Unity_Subtract_float(_Property_5e920479576fad83ba1947728dcceab4_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2);
                    float _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2;
                    Unity_Maximum_float(_Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2, 0, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2);
                    float3 _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2;
                    Unity_Multiply_float(_Property_c7292b3b08585f8c8670172b9a220bf0_Out_0, (_Maximum_216777d30802328eab607c8fe68ba3a1_Out_2.xxx), _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2);
                    float3 _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2;
                    Unity_Add_float3(_Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2, _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2, _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2);
                    float _Add_356384b52728f583bd6e694bc1fc3738_Out_2;
                    Unity_Add_float(_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2, _Add_356384b52728f583bd6e694bc1fc3738_Out_2);
                    float _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2;
                    Unity_Maximum_float(_Add_356384b52728f583bd6e694bc1fc3738_Out_2, 1E-05, _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2);
                    float3 _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
                    Unity_Divide_float3(_Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2, (_Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2.xxx), _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2);
                    OutVector4_1 = _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7;
                    float3 _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1;
                    SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7, _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1);
                    description.Position = _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float3 NormalTS;
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    float4 _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0 = _BaseTilingOffset;
                    float _Property_7f998178363b4188ba2f07298ef869c1_Out_0 = _BaseUsePlanarUV;
                    Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8;
                    _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceTangent = IN.WorldSpaceTangent;
                    _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                    _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8.uv0 = IN.uv0;
                    float4 _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2;
                    SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_ARGS(_BaseNormalMap, sampler_BaseNormalMap), _BaseNormalMap_TexelSize, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8, _PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2);
                    float _Property_d4b0759cf4647e81be065ec1465ce2b4_Out_0 = _BaseNormalScale;
                    float3 _NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2;
                    Unity_NormalStrength_float((_PlanarNMn_a3713a9c3874b6838d0eda971b9c62d8_XZ_2.xyz), _Property_d4b0759cf4647e81be065ec1465ce2b4_Out_0, _NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2);
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_4245c3b264047180b5c90a697d6cb278;
                    _PlanarNM_4245c3b264047180b5c90a697d6cb278.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_4245c3b264047180b5c90a697d6cb278.uv0 = IN.uv0;
                    float4 _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseMaskMap, sampler_BaseMaskMap), _BaseMaskMap_TexelSize, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_4245c3b264047180b5c90a697d6cb278, _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2);
                    float _Split_91a015dea8acd38b904ba0935328a5bc_R_1 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[0];
                    float _Split_91a015dea8acd38b904ba0935328a5bc_G_2 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[1];
                    float _Split_91a015dea8acd38b904ba0935328a5bc_B_3 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[2];
                    float _Split_91a015dea8acd38b904ba0935328a5bc_A_4 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[3];
                    float _Property_fbcff1469ebf488394a8a89ddaf0eb2a_Out_0 = _HeightMin;
                    float _Property_9df7a44c8225168683743ac60c0c3c34_Out_0 = _HeightMax;
                    float2 _Vector2_9b1e95888c28bc8893f28c02b87fa448_Out_0 = float2(_Property_fbcff1469ebf488394a8a89ddaf0eb2a_Out_0, _Property_9df7a44c8225168683743ac60c0c3c34_Out_0);
                    float _Property_29ca14fd0b712983a38d63d2dd326e96_Out_0 = _HeightOffset;
                    float2 _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2;
                    Unity_Add_float2(_Vector2_9b1e95888c28bc8893f28c02b87fa448_Out_0, (_Property_29ca14fd0b712983a38d63d2dd326e96_Out_0.xx), _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2);
                    float _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3;
                    Unity_Remap_float(_Split_91a015dea8acd38b904ba0935328a5bc_B_3, float2 (0, 1), _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3);
                    float4 _Property_86a4657df480d48e8d3ad3b036731380_Out_0 = _Base2TilingOffset;
                    float _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0 = _Base2UsePlanarUV;
                    Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf;
                    _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceNormal = IN.WorldSpaceNormal;
                    _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceTangent = IN.WorldSpaceTangent;
                    _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                    _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf.uv0 = IN.uv0;
                    float4 _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2;
                    SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_ARGS(_Base2NormalMap, sampler_Base2NormalMap), _Base2NormalMap_TexelSize, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf, _PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2);
                    float _Property_8c31443b776727819a663c7ddce79064_Out_0 = _Base2NormalScale;
                    float3 _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2;
                    Unity_NormalStrength_float((_PlanarNMn_d7b3ec528088a085a5102e025a1b45cf_XZ_2.xyz), _Property_8c31443b776727819a663c7ddce79064_Out_0, _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2);
                    float _Split_85f63081c1b7bc8c83d6bbf4ba6648c5_R_1 = IN.VertexColor[0];
                    float _Split_85f63081c1b7bc8c83d6bbf4ba6648c5_G_2 = IN.VertexColor[1];
                    float _Split_85f63081c1b7bc8c83d6bbf4ba6648c5_B_3 = IN.VertexColor[2];
                    float _Split_85f63081c1b7bc8c83d6bbf4ba6648c5_A_4 = IN.VertexColor[3];
                    float _Property_df2df7bb5cfc3381beee7ec454da7542_Out_0 = _Invert_Layer_Mask;
                    float4 _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0 = SAMPLE_TEXTURE2D(_LayerMask, sampler_LayerMask, IN.uv0.xy);
                    float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.r;
                    float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_G_5 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.g;
                    float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_B_6 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.b;
                    float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_A_7 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.a;
                    float _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1;
                    Unity_OneMinus_float(_SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1);
                    float _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3;
                    Unity_Branch_float(_Property_df2df7bb5cfc3381beee7ec454da7542_Out_0, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1, _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3);
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb;
                    _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.uv0 = IN.uv0;
                    float4 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_Base2MaskMap, sampler_Base2MaskMap), _Base2MaskMap_TexelSize, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2);
                    float _Split_83ec66b648ab6c84848b42686c256cd7_R_1 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[0];
                    float _Split_83ec66b648ab6c84848b42686c256cd7_G_2 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[1];
                    float _Split_83ec66b648ab6c84848b42686c256cd7_B_3 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[2];
                    float _Split_83ec66b648ab6c84848b42686c256cd7_A_4 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[3];
                    float _Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0 = _HeightMin2;
                    float _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0 = _HeightMax2;
                    float2 _Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0 = float2(_Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0, _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0);
                    float _Property_151ae2702b614585af2000f0a812960f_Out_0 = _HeightOffset2;
                    float2 _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2;
                    Unity_Add_float2(_Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0, (_Property_151ae2702b614585af2000f0a812960f_Out_0.xx), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2);
                    float _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3;
                    Unity_Remap_float(_Split_83ec66b648ab6c84848b42686c256cd7_B_3, float2 (0, 1), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3);
                    float _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2;
                    Unity_Multiply_float(_Branch_af0c5e511241ce8eae748ae487df50fa_Out_3, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2);
                    float _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2;
                    Unity_Multiply_float(_Split_85f63081c1b7bc8c83d6bbf4ba6648c5_B_3, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2);
                    float _Property_818c8af4b930138e81034c886614171d_Out_0 = _Height_Transition;
                    Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_7c09d97625efce898e21b66cd039be8b;
                    float3 _HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1;
                    SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(_NormalStrength_f66a9108ea294886acc61513b41cc5e4_Out_2, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3, _NormalStrength_0fb86880ab8e368dac6d01b830e20ed8_Out_2, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Property_818c8af4b930138e81034c886614171d_Out_0, _HeightBlend_7c09d97625efce898e21b66cd039be8b, _HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1);
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e;
                    _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.uv0 = IN.uv0;
                    float4 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2);
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_R_1 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[0];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_G_2 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[1];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_B_3 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[2];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[3];
                    float _Property_8bc98dd454a5508b9864a6ba09772356_Out_0 = _AlphaCutoff;
                    surface.NormalTS = _HeightBlend_7c09d97625efce898e21b66cd039be8b_OutVector4_1;
                    surface.Alpha = _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4;
                    surface.AlphaClipThreshold = _Property_8bc98dd454a5508b9864a6ba09772356_Out_0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.ObjectSpacePosition =         input.positionOS;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                	// must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
                	float3 unnormalizedNormalWS = input.normalWS;
                    const float renormFactor = 1.0 / length(unnormalizedNormalWS);
                
                	// use bitangent on the fly like in hdrp
                	// IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
                    float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
                	float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
                
                    output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
                    output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                
                	// to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
                	// This is explained in section 2.2 in "surface gradient based bump mapping framework"
                    output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
                	output.WorldSpaceBiTangent =         renormFactor*bitang;
                
                    output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
                    output.uv0 =                         input.texCoord0;
                    output.VertexColor =                 input.color;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthNormalsOnlyPass.hlsl"
    
                ENDHLSL
            }
            Pass
            {
                Name "Meta"
                Tags
                {
                    "LightMode" = "Meta"
                }
    
                // Render State
                Cull Off
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 2.0
                #pragma only_renderers gles gles3 glcore
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                #pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
                // GraphKeywords: <None>
    
                // Defines
                #define _AlphaClip 1
                #define _NORMALMAP 1
                #define _NORMAL_DROPOFF_TS 1
                #define ATTRIBUTES_NEED_NORMAL
                #define ATTRIBUTES_NEED_TANGENT
                #define ATTRIBUTES_NEED_TEXCOORD0
                #define ATTRIBUTES_NEED_TEXCOORD1
                #define ATTRIBUTES_NEED_TEXCOORD2
                #define ATTRIBUTES_NEED_COLOR
                #define VARYINGS_NEED_POSITION_WS
                #define VARYINGS_NEED_TEXCOORD0
                #define VARYINGS_NEED_COLOR
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_META
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    float3 positionOS : POSITION;
                    float3 normalOS : NORMAL;
                    float4 tangentOS : TANGENT;
                    float4 uv0 : TEXCOORD0;
                    float4 uv1 : TEXCOORD1;
                    float4 uv2 : TEXCOORD2;
                    float4 color : COLOR;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                };
                struct Varyings
                {
                    float4 positionCS : SV_POSITION;
                    float3 positionWS;
                    float4 texCoord0;
                    float4 color;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    float3 AbsoluteWorldSpacePosition;
                    float4 uv0;
                    float4 VertexColor;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 ObjectSpacePosition;
                };
                struct PackedVaryings
                {
                    float4 positionCS : SV_POSITION;
                    float3 interp0 : TEXCOORD0;
                    float4 interp1 : TEXCOORD1;
                    float4 interp2 : TEXCOORD2;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
    
                PackedVaryings PackVaryings (Varyings input)
                {
                    PackedVaryings output;
                    output.positionCS = input.positionCS;
                    output.interp0.xyz =  input.positionWS;
                    output.interp1.xyzw =  input.texCoord0;
                    output.interp2.xyzw =  input.color;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
                Varyings UnpackVaryings (PackedVaryings input)
                {
                    Varyings output;
                    output.positionCS = input.positionCS;
                    output.positionWS = input.interp0.xyz;
                    output.texCoord0 = input.interp1.xyzw;
                    output.color = input.interp2.xyzw;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _AlphaCutoff;
                float4 _BaseColor;
                float4 _BaseColorMap_TexelSize;
                float _BaseUsePlanarUV;
                float4 _BaseTilingOffset;
                float4 _BaseNormalMap_TexelSize;
                float _BaseNormalScale;
                float4 _BaseMaskMap_TexelSize;
                float _BaseMetallic;
                float _BaseAORemapMin;
                float _BaseAORemapMax;
                float _BaseSmoothnessRemapMin;
                float _BaseSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float _Invert_Layer_Mask;
                float _Height_Transition;
                float _HeightMin;
                float _HeightMax;
                float _HeightOffset;
                float _HeightMin2;
                float _HeightMax2;
                float _HeightOffset2;
                float4 _Base2Color;
                float4 _Base2ColorMap_TexelSize;
                float4 _Base2TilingOffset;
                float _Base2UsePlanarUV;
                float4 _Base2NormalMap_TexelSize;
                float _Base2NormalScale;
                float4 _Base2MaskMap_TexelSize;
                float _Base2Metallic;
                float _Base2SmoothnessRemapMin;
                float _Base2SmoothnessRemapMax;
                float _Base2AORemapMin;
                float _Base2AORemapMax;
                float4 _WetColor;
                float _WetSmoothness;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_BaseColorMap);
                SAMPLER(sampler_BaseColorMap);
                TEXTURE2D(_BaseNormalMap);
                SAMPLER(sampler_BaseNormalMap);
                TEXTURE2D(_BaseMaskMap);
                SAMPLER(sampler_BaseMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_Base2ColorMap);
                SAMPLER(sampler_Base2ColorMap);
                TEXTURE2D(_Base2NormalMap);
                SAMPLER(sampler_Base2NormalMap);
                TEXTURE2D(_Base2MaskMap);
                SAMPLER(sampler_Base2MaskMap);
                SAMPLER(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 6a9c7522090e0644e0cdf14d6feac267
                #include "Assets/NatureManufacture Assets/Object Shaders/NM_Object_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b
                {
                };
                
                void SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(float3 Vector3_314C8600, Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                {
                    Out = A * B;
                }
                
                void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                {
                    Out = UV * Tiling + Offset;
                }
                
                void Unity_Branch_float2(float Predicate, float2 True, float2 False, out float2 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                struct Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6
                {
                    float3 AbsoluteWorldSpacePosition;
                    half4 uv0;
                };
                
                void SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float4 Vector4_2EBA7A3B, float Boolean_7ABB9909, Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 IN, out float4 XZ_2)
                {
                    float _Property_30834f691775a0898a45b1c868520436_Out_0 = Boolean_7ABB9909;
                    float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
                    float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
                    float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
                    float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
                    float4 _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0 = Vector4_2EBA7A3B;
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[0];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[1];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[2];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[3];
                    float _Divide_e64179199923c58289b6aa94ea6c9178_Out_2;
                    Unity_Divide_float(1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Divide_e64179199923c58289b6aa94ea6c9178_Out_2);
                    float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
                    Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_e64179199923c58289b6aa94ea6c9178_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
                    float2 _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2);
                    float2 _Vector2_f8d75f54e7705083bbec539a60185577_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4);
                    float2 _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0, _Vector2_f8d75f54e7705083bbec539a60185577_Out_0, _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3);
                    float2 _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3;
                    Unity_Branch_float2(_Property_30834f691775a0898a45b1c868520436_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
                    float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
                    XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
                }
                
                void Unity_Add_float2(float2 A, float2 B, out float2 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
                {
                    Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
                }
                
                void Unity_OneMinus_float(float In, out float Out)
                {
                    Out = 1 - In;
                }
                
                void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Maximum_float(float A, float B, out float Out)
                {
                    Out = max(A, B);
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Add_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A / B;
                }
                
                struct Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135
                {
                };
                
                void SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(float3 Vector3_88EEBB5E, float Vector1_DA0A37FA, float3 Vector3_79AA92F, float Vector1_F7E83F1E, float Vector1_1C9222A6, Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 IN, out float3 OutVector4_1)
                {
                    float3 _Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0 = Vector3_88EEBB5E;
                    float _Property_14119cc7eaf4128f991283d47cf72d85_Out_0 = Vector1_DA0A37FA;
                    float _Property_48af0ad45e3f7f82932b938695d21391_Out_0 = Vector1_DA0A37FA;
                    float _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0 = Vector1_F7E83F1E;
                    float _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2;
                    Unity_Maximum_float(_Property_48af0ad45e3f7f82932b938695d21391_Out_0, _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0, _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2);
                    float _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0 = Vector1_1C9222A6;
                    float _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2;
                    Unity_Subtract_float(_Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2, _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2);
                    float _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2;
                    Unity_Subtract_float(_Property_14119cc7eaf4128f991283d47cf72d85_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2);
                    float _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2;
                    Unity_Maximum_float(_Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2, 0, _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2);
                    float3 _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2;
                    Unity_Multiply_float(_Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0, (_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2.xxx), _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2);
                    float3 _Property_c7292b3b08585f8c8670172b9a220bf0_Out_0 = Vector3_79AA92F;
                    float _Property_5e920479576fad83ba1947728dcceab4_Out_0 = Vector1_F7E83F1E;
                    float _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2;
                    Unity_Subtract_float(_Property_5e920479576fad83ba1947728dcceab4_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2);
                    float _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2;
                    Unity_Maximum_float(_Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2, 0, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2);
                    float3 _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2;
                    Unity_Multiply_float(_Property_c7292b3b08585f8c8670172b9a220bf0_Out_0, (_Maximum_216777d30802328eab607c8fe68ba3a1_Out_2.xxx), _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2);
                    float3 _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2;
                    Unity_Add_float3(_Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2, _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2, _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2);
                    float _Add_356384b52728f583bd6e694bc1fc3738_Out_2;
                    Unity_Add_float(_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2, _Add_356384b52728f583bd6e694bc1fc3738_Out_2);
                    float _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2;
                    Unity_Maximum_float(_Add_356384b52728f583bd6e694bc1fc3738_Out_2, 1E-05, _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2);
                    float3 _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
                    Unity_Divide_float3(_Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2, (_Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2.xxx), _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2);
                    OutVector4_1 = _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
                }
                
                void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
                {
                    Out = lerp(A, B, T);
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7;
                    float3 _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1;
                    SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7, _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1);
                    description.Position = _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float3 BaseColor;
                    float3 Emission;
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    float4 _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0 = _BaseTilingOffset;
                    float _Property_7f998178363b4188ba2f07298ef869c1_Out_0 = _BaseUsePlanarUV;
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e;
                    _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.uv0 = IN.uv0;
                    float4 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2);
                    float4 _Property_b83097c58639858680bf43881a95b0af_Out_0 = _BaseColor;
                    float4 _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2;
                    Unity_Multiply_float(_PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2, _Property_b83097c58639858680bf43881a95b0af_Out_0, _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2);
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_4245c3b264047180b5c90a697d6cb278;
                    _PlanarNM_4245c3b264047180b5c90a697d6cb278.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_4245c3b264047180b5c90a697d6cb278.uv0 = IN.uv0;
                    float4 _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseMaskMap, sampler_BaseMaskMap), _BaseMaskMap_TexelSize, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_4245c3b264047180b5c90a697d6cb278, _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2);
                    float _Split_91a015dea8acd38b904ba0935328a5bc_R_1 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[0];
                    float _Split_91a015dea8acd38b904ba0935328a5bc_G_2 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[1];
                    float _Split_91a015dea8acd38b904ba0935328a5bc_B_3 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[2];
                    float _Split_91a015dea8acd38b904ba0935328a5bc_A_4 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[3];
                    float _Property_fbcff1469ebf488394a8a89ddaf0eb2a_Out_0 = _HeightMin;
                    float _Property_9df7a44c8225168683743ac60c0c3c34_Out_0 = _HeightMax;
                    float2 _Vector2_9b1e95888c28bc8893f28c02b87fa448_Out_0 = float2(_Property_fbcff1469ebf488394a8a89ddaf0eb2a_Out_0, _Property_9df7a44c8225168683743ac60c0c3c34_Out_0);
                    float _Property_29ca14fd0b712983a38d63d2dd326e96_Out_0 = _HeightOffset;
                    float2 _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2;
                    Unity_Add_float2(_Vector2_9b1e95888c28bc8893f28c02b87fa448_Out_0, (_Property_29ca14fd0b712983a38d63d2dd326e96_Out_0.xx), _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2);
                    float _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3;
                    Unity_Remap_float(_Split_91a015dea8acd38b904ba0935328a5bc_B_3, float2 (0, 1), _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3);
                    float4 _Property_86a4657df480d48e8d3ad3b036731380_Out_0 = _Base2TilingOffset;
                    float _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0 = _Base2UsePlanarUV;
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4;
                    _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.uv0 = IN.uv0;
                    float4 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_Base2ColorMap, sampler_Base2ColorMap), _Base2ColorMap_TexelSize, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2);
                    float4 _Property_3561b11b899bda8e855826445cf628aa_Out_0 = _Base2Color;
                    float4 _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2;
                    Unity_Multiply_float(_PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2, _Property_3561b11b899bda8e855826445cf628aa_Out_0, _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2);
                    float _Split_85f63081c1b7bc8c83d6bbf4ba6648c5_R_1 = IN.VertexColor[0];
                    float _Split_85f63081c1b7bc8c83d6bbf4ba6648c5_G_2 = IN.VertexColor[1];
                    float _Split_85f63081c1b7bc8c83d6bbf4ba6648c5_B_3 = IN.VertexColor[2];
                    float _Split_85f63081c1b7bc8c83d6bbf4ba6648c5_A_4 = IN.VertexColor[3];
                    float _Property_df2df7bb5cfc3381beee7ec454da7542_Out_0 = _Invert_Layer_Mask;
                    float4 _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0 = SAMPLE_TEXTURE2D(_LayerMask, sampler_LayerMask, IN.uv0.xy);
                    float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.r;
                    float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_G_5 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.g;
                    float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_B_6 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.b;
                    float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_A_7 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.a;
                    float _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1;
                    Unity_OneMinus_float(_SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1);
                    float _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3;
                    Unity_Branch_float(_Property_df2df7bb5cfc3381beee7ec454da7542_Out_0, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1, _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3);
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb;
                    _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.uv0 = IN.uv0;
                    float4 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_Base2MaskMap, sampler_Base2MaskMap), _Base2MaskMap_TexelSize, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2);
                    float _Split_83ec66b648ab6c84848b42686c256cd7_R_1 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[0];
                    float _Split_83ec66b648ab6c84848b42686c256cd7_G_2 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[1];
                    float _Split_83ec66b648ab6c84848b42686c256cd7_B_3 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[2];
                    float _Split_83ec66b648ab6c84848b42686c256cd7_A_4 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[3];
                    float _Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0 = _HeightMin2;
                    float _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0 = _HeightMax2;
                    float2 _Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0 = float2(_Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0, _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0);
                    float _Property_151ae2702b614585af2000f0a812960f_Out_0 = _HeightOffset2;
                    float2 _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2;
                    Unity_Add_float2(_Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0, (_Property_151ae2702b614585af2000f0a812960f_Out_0.xx), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2);
                    float _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3;
                    Unity_Remap_float(_Split_83ec66b648ab6c84848b42686c256cd7_B_3, float2 (0, 1), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3);
                    float _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2;
                    Unity_Multiply_float(_Branch_af0c5e511241ce8eae748ae487df50fa_Out_3, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2);
                    float _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2;
                    Unity_Multiply_float(_Split_85f63081c1b7bc8c83d6bbf4ba6648c5_B_3, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2);
                    float _Property_818c8af4b930138e81034c886614171d_Out_0 = _Height_Transition;
                    Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_7501025b3a60738a9a9d362e35a9ab48;
                    float3 _HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1;
                    SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135((_Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2.xyz), _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3, (_Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2.xyz), _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Property_818c8af4b930138e81034c886614171d_Out_0, _HeightBlend_7501025b3a60738a9a9d362e35a9ab48, _HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1);
                    float4 _Property_696647de24586381a15debb755f8f569_Out_0 = _WetColor;
                    float3 _Multiply_dec52e2895a185829e24dfeaeeba8184_Out_2;
                    Unity_Multiply_float((_Property_696647de24586381a15debb755f8f569_Out_0.xyz), _HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1, _Multiply_dec52e2895a185829e24dfeaeeba8184_Out_2);
                    float _OneMinus_0b9ce7d9f924bf8193dc9bdd9b2268e1_Out_1;
                    Unity_OneMinus_float(_Split_85f63081c1b7bc8c83d6bbf4ba6648c5_R_1, _OneMinus_0b9ce7d9f924bf8193dc9bdd9b2268e1_Out_1);
                    float3 _Lerp_7a7642d5ea869889935d4d1799cc7ad3_Out_3;
                    Unity_Lerp_float3(_HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1, _Multiply_dec52e2895a185829e24dfeaeeba8184_Out_2, (_OneMinus_0b9ce7d9f924bf8193dc9bdd9b2268e1_Out_1.xxx), _Lerp_7a7642d5ea869889935d4d1799cc7ad3_Out_3);
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_R_1 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[0];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_G_2 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[1];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_B_3 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[2];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[3];
                    float _Property_8bc98dd454a5508b9864a6ba09772356_Out_0 = _AlphaCutoff;
                    surface.BaseColor = _Lerp_7a7642d5ea869889935d4d1799cc7ad3_Out_3;
                    surface.Emission = float3(0, 0, 0);
                    surface.Alpha = _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4;
                    surface.AlphaClipThreshold = _Property_8bc98dd454a5508b9864a6ba09772356_Out_0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.ObjectSpacePosition =         input.positionOS;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                
                
                
                
                    output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
                    output.uv0 =                         input.texCoord0;
                    output.VertexColor =                 input.color;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/LightingMetaPass.hlsl"
    
                ENDHLSL
            }
            Pass
            {
                // Name: <None>
                Tags
                {
                    "LightMode" = "Universal2D"
                }
    
                // Render State
                Cull Back
                Blend One Zero
                ZTest LEqual
                ZWrite On
    
                // Debug
                // <None>
    
                // --------------------------------------------------
                // Pass
    
                HLSLPROGRAM
    
                // Pragmas
                #pragma target 2.0
                #pragma only_renderers gles gles3 glcore
                #pragma multi_compile_instancing
                #pragma vertex vert
                #pragma fragment frag
    
                // DotsInstancingOptions: <None>
                // HybridV1InjectedBuiltinProperties: <None>
    
                // Keywords
                // PassKeywords: <None>
                // GraphKeywords: <None>
    
                // Defines
                #define _AlphaClip 1
                #define _NORMALMAP 1
                #define _NORMAL_DROPOFF_TS 1
                #define ATTRIBUTES_NEED_NORMAL
                #define ATTRIBUTES_NEED_TANGENT
                #define ATTRIBUTES_NEED_TEXCOORD0
                #define ATTRIBUTES_NEED_COLOR
                #define VARYINGS_NEED_POSITION_WS
                #define VARYINGS_NEED_TEXCOORD0
                #define VARYINGS_NEED_COLOR
                #define FEATURES_GRAPH_VERTEX
                /* WARNING: $splice Could not find named fragment 'PassInstancing' */
                #define SHADERPASS SHADERPASS_2D
                /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
    
                // Includes
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
                #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
    
                // --------------------------------------------------
                // Structs and Packing
    
                struct Attributes
                {
                    float3 positionOS : POSITION;
                    float3 normalOS : NORMAL;
                    float4 tangentOS : TANGENT;
                    float4 uv0 : TEXCOORD0;
                    float4 color : COLOR;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : INSTANCEID_SEMANTIC;
                    #endif
                };
                struct Varyings
                {
                    float4 positionCS : SV_POSITION;
                    float3 positionWS;
                    float4 texCoord0;
                    float4 color;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
                struct SurfaceDescriptionInputs
                {
                    float3 AbsoluteWorldSpacePosition;
                    float4 uv0;
                    float4 VertexColor;
                };
                struct VertexDescriptionInputs
                {
                    float3 ObjectSpaceNormal;
                    float3 ObjectSpaceTangent;
                    float3 ObjectSpacePosition;
                };
                struct PackedVaryings
                {
                    float4 positionCS : SV_POSITION;
                    float3 interp0 : TEXCOORD0;
                    float4 interp1 : TEXCOORD1;
                    float4 interp2 : TEXCOORD2;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    uint instanceID : CUSTOM_INSTANCE_ID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                    #endif
                };
    
                PackedVaryings PackVaryings (Varyings input)
                {
                    PackedVaryings output;
                    output.positionCS = input.positionCS;
                    output.interp0.xyz =  input.positionWS;
                    output.interp1.xyzw =  input.texCoord0;
                    output.interp2.xyzw =  input.color;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
                Varyings UnpackVaryings (PackedVaryings input)
                {
                    Varyings output;
                    output.positionCS = input.positionCS;
                    output.positionWS = input.interp0.xyz;
                    output.texCoord0 = input.interp1.xyzw;
                    output.color = input.interp2.xyzw;
                    #if UNITY_ANY_INSTANCING_ENABLED
                    output.instanceID = input.instanceID;
                    #endif
                    #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                    output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                    #endif
                    #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                    output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                    #endif
                    #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                    output.cullFace = input.cullFace;
                    #endif
                    return output;
                }
    
                // --------------------------------------------------
                // Graph
    
                // Graph Properties
                CBUFFER_START(UnityPerMaterial)
                float _AlphaCutoff;
                float4 _BaseColor;
                float4 _BaseColorMap_TexelSize;
                float _BaseUsePlanarUV;
                float4 _BaseTilingOffset;
                float4 _BaseNormalMap_TexelSize;
                float _BaseNormalScale;
                float4 _BaseMaskMap_TexelSize;
                float _BaseMetallic;
                float _BaseAORemapMin;
                float _BaseAORemapMax;
                float _BaseSmoothnessRemapMin;
                float _BaseSmoothnessRemapMax;
                float4 _LayerMask_TexelSize;
                float _Invert_Layer_Mask;
                float _Height_Transition;
                float _HeightMin;
                float _HeightMax;
                float _HeightOffset;
                float _HeightMin2;
                float _HeightMax2;
                float _HeightOffset2;
                float4 _Base2Color;
                float4 _Base2ColorMap_TexelSize;
                float4 _Base2TilingOffset;
                float _Base2UsePlanarUV;
                float4 _Base2NormalMap_TexelSize;
                float _Base2NormalScale;
                float4 _Base2MaskMap_TexelSize;
                float _Base2Metallic;
                float _Base2SmoothnessRemapMin;
                float _Base2SmoothnessRemapMax;
                float _Base2AORemapMin;
                float _Base2AORemapMax;
                float4 _WetColor;
                float _WetSmoothness;
                CBUFFER_END
                
                // Object and Global properties
                TEXTURE2D(_BaseColorMap);
                SAMPLER(sampler_BaseColorMap);
                TEXTURE2D(_BaseNormalMap);
                SAMPLER(sampler_BaseNormalMap);
                TEXTURE2D(_BaseMaskMap);
                SAMPLER(sampler_BaseMaskMap);
                TEXTURE2D(_LayerMask);
                SAMPLER(sampler_LayerMask);
                TEXTURE2D(_Base2ColorMap);
                SAMPLER(sampler_Base2ColorMap);
                TEXTURE2D(_Base2NormalMap);
                SAMPLER(sampler_Base2NormalMap);
                TEXTURE2D(_Base2MaskMap);
                SAMPLER(sampler_Base2MaskMap);
                SAMPLER(_SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_Sampler_3_Linear_Repeat);
                SAMPLER(_SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_Sampler_3_Linear_Repeat);
    
                // Graph Functions
                
                // 6a9c7522090e0644e0cdf14d6feac267
                #include "Assets/NatureManufacture Assets/Object Shaders/NM_Object_VSPro_Indirect.cginc"
                
                void AddPragma_float(float3 A, out float3 Out)
                {
                    #pragma instancing_options renderinglayer procedural:setupVSPro
                    Out = A;
                }
                
                struct Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b
                {
                };
                
                void SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(float3 Vector3_314C8600, Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b IN, out float3 ObjectSpacePosition_1)
                {
                    float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
                    float3 _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
                    InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
                    float3 _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                    AddPragma_float(_CustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
                    ObjectSpacePosition_1 = _CustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
                }
                
                void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                {
                    RGBA = float4(R, G, B, A);
                    RGB = float3(R, G, B);
                    RG = float2(R, G);
                }
                
                void Unity_Divide_float(float A, float B, out float Out)
                {
                    Out = A / B;
                }
                
                void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
                {
                    Out = A * B;
                }
                
                void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                {
                    Out = UV * Tiling + Offset;
                }
                
                void Unity_Branch_float2(float Predicate, float2 True, float2 False, out float2 Out)
                {
                    Out = Predicate ? True : False;
                }
                
                struct Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6
                {
                    float3 AbsoluteWorldSpacePosition;
                    half4 uv0;
                };
                
                void SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float4 Vector4_2EBA7A3B, float Boolean_7ABB9909, Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 IN, out float4 XZ_2)
                {
                    float _Property_30834f691775a0898a45b1c868520436_Out_0 = Boolean_7ABB9909;
                    float _Split_89ed63cb625cb3878c183d0b71c03400_R_1 = IN.AbsoluteWorldSpacePosition[0];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_G_2 = IN.AbsoluteWorldSpacePosition[1];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_B_3 = IN.AbsoluteWorldSpacePosition[2];
                    float _Split_89ed63cb625cb3878c183d0b71c03400_A_4 = 0;
                    float4 _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4;
                    float3 _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5;
                    float2 _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6;
                    Unity_Combine_float(_Split_89ed63cb625cb3878c183d0b71c03400_R_1, _Split_89ed63cb625cb3878c183d0b71c03400_B_3, 0, 0, _Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, _Combine_cf2d04ff119ad88493f6460431765cbb_RGB_5, _Combine_cf2d04ff119ad88493f6460431765cbb_RG_6);
                    float4 _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0 = Vector4_2EBA7A3B;
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[0];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[1];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[2];
                    float _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4 = _Property_8a66888ec47d0687ab1cb2f8abdc9da8_Out_0[3];
                    float _Divide_e64179199923c58289b6aa94ea6c9178_Out_2;
                    Unity_Divide_float(1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Divide_e64179199923c58289b6aa94ea6c9178_Out_2);
                    float4 _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2;
                    Unity_Multiply_float(_Combine_cf2d04ff119ad88493f6460431765cbb_RGBA_4, (_Divide_e64179199923c58289b6aa94ea6c9178_Out_2.xxxx), _Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2);
                    float2 _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_R_1, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_G_2);
                    float2 _Vector2_f8d75f54e7705083bbec539a60185577_Out_0 = float2(_Split_2f0f52f6ef8c0e81af0da6476402bc1f_B_3, _Split_2f0f52f6ef8c0e81af0da6476402bc1f_A_4);
                    float2 _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3;
                    Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_16c15d3bbdd14b85bd48e3a6cb318af7_Out_0, _Vector2_f8d75f54e7705083bbec539a60185577_Out_0, _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3);
                    float2 _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3;
                    Unity_Branch_float2(_Property_30834f691775a0898a45b1c868520436_Out_0, (_Multiply_14cec4902d0a00829e4555071a1b8ad1_Out_2.xy), _TilingAndOffset_d91e2d25acd34686b562b7fe7e9d1d27_Out_3, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
                    float4 _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Branch_8e5a4e8f4d52fc8aadd1f46485afc933_Out_3);
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_R_4 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.r;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_G_5 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.g;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_B_6 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.b;
                    float _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_A_7 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0.a;
                    XZ_2 = _SampleTexture2D_35ddc0da4b30e48b83ca2d39af2aba2c_RGBA_0;
                }
                
                void Unity_Add_float2(float2 A, float2 B, out float2 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
                {
                    Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
                }
                
                void Unity_OneMinus_float(float In, out float Out)
                {
                    Out = 1 - In;
                }
                
                void Unity_Branch_float(float Predicate, float True, float False, out float Out)
                {
                    Out = Predicate ? True : False;
                }
                
                void Unity_Multiply_float(float A, float B, out float Out)
                {
                    Out = A * B;
                }
                
                void Unity_Maximum_float(float A, float B, out float Out)
                {
                    Out = max(A, B);
                }
                
                void Unity_Subtract_float(float A, float B, out float Out)
                {
                    Out = A - B;
                }
                
                void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
                {
                    Out = A * B;
                }
                
                void Unity_Add_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A + B;
                }
                
                void Unity_Add_float(float A, float B, out float Out)
                {
                    Out = A + B;
                }
                
                void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
                {
                    Out = A / B;
                }
                
                struct Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135
                {
                };
                
                void SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(float3 Vector3_88EEBB5E, float Vector1_DA0A37FA, float3 Vector3_79AA92F, float Vector1_F7E83F1E, float Vector1_1C9222A6, Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 IN, out float3 OutVector4_1)
                {
                    float3 _Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0 = Vector3_88EEBB5E;
                    float _Property_14119cc7eaf4128f991283d47cf72d85_Out_0 = Vector1_DA0A37FA;
                    float _Property_48af0ad45e3f7f82932b938695d21391_Out_0 = Vector1_DA0A37FA;
                    float _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0 = Vector1_F7E83F1E;
                    float _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2;
                    Unity_Maximum_float(_Property_48af0ad45e3f7f82932b938695d21391_Out_0, _Property_8a30b3ca12ff518fa473ccd686c7d503_Out_0, _Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2);
                    float _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0 = Vector1_1C9222A6;
                    float _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2;
                    Unity_Subtract_float(_Maximum_c196e4a61637ea8381a3437c93f89ce2_Out_2, _Property_ee8d5fc69475d181be60c57e04ea8708_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2);
                    float _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2;
                    Unity_Subtract_float(_Property_14119cc7eaf4128f991283d47cf72d85_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2);
                    float _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2;
                    Unity_Maximum_float(_Subtract_e3a7713b556a1b8cb40aad97fc58d619_Out_2, 0, _Maximum_d02e48d92038448cb0345e5cf3779071_Out_2);
                    float3 _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2;
                    Unity_Multiply_float(_Property_dd1c841a04c03f8c85e7b00eb025ecda_Out_0, (_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2.xxx), _Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2);
                    float3 _Property_c7292b3b08585f8c8670172b9a220bf0_Out_0 = Vector3_79AA92F;
                    float _Property_5e920479576fad83ba1947728dcceab4_Out_0 = Vector1_F7E83F1E;
                    float _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2;
                    Unity_Subtract_float(_Property_5e920479576fad83ba1947728dcceab4_Out_0, _Subtract_61ca880c04c1758eb128f25c9faabd63_Out_2, _Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2);
                    float _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2;
                    Unity_Maximum_float(_Subtract_b7368f21be9e048aae7f90c8a2bfaae1_Out_2, 0, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2);
                    float3 _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2;
                    Unity_Multiply_float(_Property_c7292b3b08585f8c8670172b9a220bf0_Out_0, (_Maximum_216777d30802328eab607c8fe68ba3a1_Out_2.xxx), _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2);
                    float3 _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2;
                    Unity_Add_float3(_Multiply_79b0b5d7d3528b8395e1135339a090f2_Out_2, _Multiply_a856b52cd0848f86a6ae1af9b175935c_Out_2, _Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2);
                    float _Add_356384b52728f583bd6e694bc1fc3738_Out_2;
                    Unity_Add_float(_Maximum_d02e48d92038448cb0345e5cf3779071_Out_2, _Maximum_216777d30802328eab607c8fe68ba3a1_Out_2, _Add_356384b52728f583bd6e694bc1fc3738_Out_2);
                    float _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2;
                    Unity_Maximum_float(_Add_356384b52728f583bd6e694bc1fc3738_Out_2, 1E-05, _Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2);
                    float3 _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
                    Unity_Divide_float3(_Add_86c6109dc4530b8c9763ef62b056ad4c_Out_2, (_Maximum_94a22f5ceb706e88bc16350a5d5d2a82_Out_2.xxx), _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2);
                    OutVector4_1 = _Divide_d7291d1701d7058dbb5263194c1bed22_Out_2;
                }
                
                void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
                {
                    Out = lerp(A, B, T);
                }
    
                // Graph Vertex
                struct VertexDescription
                {
                    float3 Position;
                    float3 Normal;
                    float3 Tangent;
                };
                
                VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                {
                    VertexDescription description = (VertexDescription)0;
                    Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7;
                    float3 _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1;
                    SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7, _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1);
                    description.Position = _NMObjectVSProIndirect_5104afa174b1e18689179637e63724e7_ObjectSpacePosition_1;
                    description.Normal = IN.ObjectSpaceNormal;
                    description.Tangent = IN.ObjectSpaceTangent;
                    return description;
                }
    
                // Graph Pixel
                struct SurfaceDescription
                {
                    float3 BaseColor;
                    float Alpha;
                    float AlphaClipThreshold;
                };
                
                SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                {
                    SurfaceDescription surface = (SurfaceDescription)0;
                    float4 _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0 = _BaseTilingOffset;
                    float _Property_7f998178363b4188ba2f07298ef869c1_Out_0 = _BaseUsePlanarUV;
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e;
                    _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e.uv0 = IN.uv0;
                    float4 _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e, _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2);
                    float4 _Property_b83097c58639858680bf43881a95b0af_Out_0 = _BaseColor;
                    float4 _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2;
                    Unity_Multiply_float(_PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2, _Property_b83097c58639858680bf43881a95b0af_Out_0, _Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2);
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_4245c3b264047180b5c90a697d6cb278;
                    _PlanarNM_4245c3b264047180b5c90a697d6cb278.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_4245c3b264047180b5c90a697d6cb278.uv0 = IN.uv0;
                    float4 _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseMaskMap, sampler_BaseMaskMap), _BaseMaskMap_TexelSize, _Property_587a28253857318a9b2e59bfc8fb56a4_Out_0, _Property_7f998178363b4188ba2f07298ef869c1_Out_0, _PlanarNM_4245c3b264047180b5c90a697d6cb278, _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2);
                    float _Split_91a015dea8acd38b904ba0935328a5bc_R_1 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[0];
                    float _Split_91a015dea8acd38b904ba0935328a5bc_G_2 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[1];
                    float _Split_91a015dea8acd38b904ba0935328a5bc_B_3 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[2];
                    float _Split_91a015dea8acd38b904ba0935328a5bc_A_4 = _PlanarNM_4245c3b264047180b5c90a697d6cb278_XZ_2[3];
                    float _Property_fbcff1469ebf488394a8a89ddaf0eb2a_Out_0 = _HeightMin;
                    float _Property_9df7a44c8225168683743ac60c0c3c34_Out_0 = _HeightMax;
                    float2 _Vector2_9b1e95888c28bc8893f28c02b87fa448_Out_0 = float2(_Property_fbcff1469ebf488394a8a89ddaf0eb2a_Out_0, _Property_9df7a44c8225168683743ac60c0c3c34_Out_0);
                    float _Property_29ca14fd0b712983a38d63d2dd326e96_Out_0 = _HeightOffset;
                    float2 _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2;
                    Unity_Add_float2(_Vector2_9b1e95888c28bc8893f28c02b87fa448_Out_0, (_Property_29ca14fd0b712983a38d63d2dd326e96_Out_0.xx), _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2);
                    float _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3;
                    Unity_Remap_float(_Split_91a015dea8acd38b904ba0935328a5bc_B_3, float2 (0, 1), _Add_cb503f8a09720d84bb03cbd89e37b80c_Out_2, _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3);
                    float4 _Property_86a4657df480d48e8d3ad3b036731380_Out_0 = _Base2TilingOffset;
                    float _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0 = _Base2UsePlanarUV;
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4;
                    _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4.uv0 = IN.uv0;
                    float4 _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_Base2ColorMap, sampler_Base2ColorMap), _Base2ColorMap_TexelSize, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4, _PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2);
                    float4 _Property_3561b11b899bda8e855826445cf628aa_Out_0 = _Base2Color;
                    float4 _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2;
                    Unity_Multiply_float(_PlanarNM_5aeab444ca6fd78ea56a01215880a5a4_XZ_2, _Property_3561b11b899bda8e855826445cf628aa_Out_0, _Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2);
                    float _Split_85f63081c1b7bc8c83d6bbf4ba6648c5_R_1 = IN.VertexColor[0];
                    float _Split_85f63081c1b7bc8c83d6bbf4ba6648c5_G_2 = IN.VertexColor[1];
                    float _Split_85f63081c1b7bc8c83d6bbf4ba6648c5_B_3 = IN.VertexColor[2];
                    float _Split_85f63081c1b7bc8c83d6bbf4ba6648c5_A_4 = IN.VertexColor[3];
                    float _Property_df2df7bb5cfc3381beee7ec454da7542_Out_0 = _Invert_Layer_Mask;
                    float4 _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0 = SAMPLE_TEXTURE2D(_LayerMask, sampler_LayerMask, IN.uv0.xy);
                    float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.r;
                    float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_G_5 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.g;
                    float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_B_6 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.b;
                    float _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_A_7 = _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_RGBA_0.a;
                    float _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1;
                    Unity_OneMinus_float(_SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1);
                    float _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3;
                    Unity_Branch_float(_Property_df2df7bb5cfc3381beee7ec454da7542_Out_0, _OneMinus_ce5c3c0635d4ac86beb55115d0ebaed7_Out_1, _SampleTexture2D_175fb18fafc9598382f1f5f7e97bf30a_R_4, _Branch_af0c5e511241ce8eae748ae487df50fa_Out_3);
                    Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb;
                    _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                    _PlanarNM_d5657f470f05ef839e4c257a20ace8cb.uv0 = IN.uv0;
                    float4 _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2;
                    SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_Base2MaskMap, sampler_Base2MaskMap), _Base2MaskMap_TexelSize, _Property_86a4657df480d48e8d3ad3b036731380_Out_0, _Property_6c5e16c615cab08a97c2a577642b9d83_Out_0, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb, _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2);
                    float _Split_83ec66b648ab6c84848b42686c256cd7_R_1 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[0];
                    float _Split_83ec66b648ab6c84848b42686c256cd7_G_2 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[1];
                    float _Split_83ec66b648ab6c84848b42686c256cd7_B_3 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[2];
                    float _Split_83ec66b648ab6c84848b42686c256cd7_A_4 = _PlanarNM_d5657f470f05ef839e4c257a20ace8cb_XZ_2[3];
                    float _Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0 = _HeightMin2;
                    float _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0 = _HeightMax2;
                    float2 _Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0 = float2(_Property_ce1750e5c69e97818667b412fc3f9f2c_Out_0, _Property_8e0f2ea54d8ede89bbabdf31a9bafd57_Out_0);
                    float _Property_151ae2702b614585af2000f0a812960f_Out_0 = _HeightOffset2;
                    float2 _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2;
                    Unity_Add_float2(_Vector2_fb6c6dd7e70e768ba686e8e94153bb96_Out_0, (_Property_151ae2702b614585af2000f0a812960f_Out_0.xx), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2);
                    float _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3;
                    Unity_Remap_float(_Split_83ec66b648ab6c84848b42686c256cd7_B_3, float2 (0, 1), _Add_fd1b3d8e24e77087a55888eeb238f1a6_Out_2, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3);
                    float _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2;
                    Unity_Multiply_float(_Branch_af0c5e511241ce8eae748ae487df50fa_Out_3, _Remap_3d4180c0ab36ba86a5517b2645f0bfa7_Out_3, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2);
                    float _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2;
                    Unity_Multiply_float(_Split_85f63081c1b7bc8c83d6bbf4ba6648c5_B_3, _Multiply_2cb0e5aa384654828f0453a44884573c_Out_2, _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2);
                    float _Property_818c8af4b930138e81034c886614171d_Out_0 = _Height_Transition;
                    Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_7501025b3a60738a9a9d362e35a9ab48;
                    float3 _HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1;
                    SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135((_Multiply_f572ff0def2d308e87a64e94a46c0d96_Out_2.xyz), _Remap_18f2e96a438d6584ae2fd56f880de9ee_Out_3, (_Multiply_d2ec682582195e84acc4a8510f50f4b0_Out_2.xyz), _Multiply_74def30593cbbb8bbed03613a31cb89a_Out_2, _Property_818c8af4b930138e81034c886614171d_Out_0, _HeightBlend_7501025b3a60738a9a9d362e35a9ab48, _HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1);
                    float4 _Property_696647de24586381a15debb755f8f569_Out_0 = _WetColor;
                    float3 _Multiply_dec52e2895a185829e24dfeaeeba8184_Out_2;
                    Unity_Multiply_float((_Property_696647de24586381a15debb755f8f569_Out_0.xyz), _HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1, _Multiply_dec52e2895a185829e24dfeaeeba8184_Out_2);
                    float _OneMinus_0b9ce7d9f924bf8193dc9bdd9b2268e1_Out_1;
                    Unity_OneMinus_float(_Split_85f63081c1b7bc8c83d6bbf4ba6648c5_R_1, _OneMinus_0b9ce7d9f924bf8193dc9bdd9b2268e1_Out_1);
                    float3 _Lerp_7a7642d5ea869889935d4d1799cc7ad3_Out_3;
                    Unity_Lerp_float3(_HeightBlend_7501025b3a60738a9a9d362e35a9ab48_OutVector4_1, _Multiply_dec52e2895a185829e24dfeaeeba8184_Out_2, (_OneMinus_0b9ce7d9f924bf8193dc9bdd9b2268e1_Out_1.xxx), _Lerp_7a7642d5ea869889935d4d1799cc7ad3_Out_3);
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_R_1 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[0];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_G_2 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[1];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_B_3 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[2];
                    float _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4 = _PlanarNM_0b8fbae0d009788d8cd595a3b9bf9f6e_XZ_2[3];
                    float _Property_8bc98dd454a5508b9864a6ba09772356_Out_0 = _AlphaCutoff;
                    surface.BaseColor = _Lerp_7a7642d5ea869889935d4d1799cc7ad3_Out_3;
                    surface.Alpha = _Split_c7a719bf7da79a8ea38d7311fd844f92_A_4;
                    surface.AlphaClipThreshold = _Property_8bc98dd454a5508b9864a6ba09772356_Out_0;
                    return surface;
                }
    
                // --------------------------------------------------
                // Build Graph Inputs
    
                VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
                {
                    VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);
                
                    output.ObjectSpaceNormal =           input.normalOS;
                    output.ObjectSpaceTangent =          input.tangentOS;
                    output.ObjectSpacePosition =         input.positionOS;
                
                    return output;
                }
                
                SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
                {
                    SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
                
                
                
                
                
                    output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
                    output.uv0 =                         input.texCoord0;
                    output.VertexColor =                 input.color;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                
                    return output;
                }
                
    
                // --------------------------------------------------
                // Main
    
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
                #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBR2DPass.hlsl"
    
                ENDHLSL
            }
        }
        CustomEditor "ShaderGraph.PBRMasterGUI"
        FallBack "Hidden/Shader Graph/FallbackError"
    }