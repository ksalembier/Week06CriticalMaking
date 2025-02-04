// Made with Amplify Shader Editor v1.9.8.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Desaturation"
{
	Properties
	{
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_Desaturation("Desaturation", Range( 0 , 2)) = 0.1706783
		_SmoothStepMin("SmoothStep Min", Range( 0 , 1)) = 0.4
		_SmoothStepMax("SmoothStep Max", Range( 0 , 1)) = 0.8
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#pragma target 3.5
		#define ASE_VERSION 19801
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _TextureSample1;
		uniform float4 _TextureSample1_ST;
		uniform float _Desaturation;
		uniform float _SmoothStepMax;
		uniform float _SmoothStepMin;
		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_TextureSample1 = i.uv_texcoord * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
			float4 tex2DNode2 = tex2D( _TextureSample1, uv_TextureSample1 );
			float dotResult10 = dot( tex2DNode2.rgb , float3( 0.2126,0.71525,0.07225 ) );
			float3 temp_cast_0 = (dotResult10).xxx;
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float smoothstepResult8 = smoothstep( ( _Desaturation - _SmoothStepMax ) , ( _Desaturation - _SmoothStepMin ) , ( 1.0 - tex2D( _TextureSample0, uv_TextureSample0 ).g ));
			float3 lerpResult13 = lerp( tex2DNode2.rgb , temp_cast_0 , smoothstepResult8);
			o.Emission = lerpResult13;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
}
/*ASEBEGIN
Version=19801
Node;AmplifyShaderEditor.RangedFloatNode;5;-1136,-496;Inherit;False;Property;_Desaturation;Desaturation;3;0;Create;True;0;0;0;False;0;False;0.1706783;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-1168,-368;Inherit;False;Property;_SmoothStepMax;SmoothStep Max;5;0;Create;True;0;0;0;False;0;False;0.8;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-1184,-192;Inherit;False;Property;_SmoothStepMin;SmoothStep Min;4;0;Create;True;0;0;0;False;0;False;0.4;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-1136,224;Inherit;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;0;False;0;False;-1;cf9944a5a53d51e40b010dc599787bfa;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SimpleSubtractOpNode;6;-609.1367,-399.2958;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;7;-635.1367,-217.2958;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-1216,-48;Inherit;True;Property;_TextureSample1;Texture Sample 1;2;0;Create;True;0;0;0;False;0;False;-1;d17a66b3d134f5e48a0b935235b07653;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.OneMinusNode;15;-704,288;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;10;-720,64;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0.2126,0.71525,0.07225;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;8;-400,288;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;13;-96,-16;Inherit;True;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;224,-16;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;0;Unlit;Desaturation;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;;0;False;;False;0;False;;0;False;;False;0;Custom;0.5;True;True;0;False;Transparent;;Geometry;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;6;0;5;0
WireConnection;6;1;3;0
WireConnection;7;0;5;0
WireConnection;7;1;4;0
WireConnection;15;0;1;2
WireConnection;10;0;2;5
WireConnection;8;0;15;0
WireConnection;8;1;6;0
WireConnection;8;2;7;0
WireConnection;13;0;2;5
WireConnection;13;1;10;0
WireConnection;13;2;8;0
WireConnection;0;2;13;0
ASEEND*/
//CHKSM=CFF179C789A093CC1DC12A19AE0AF61F248FABC0