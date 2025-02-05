// Made with Amplify Shader Editor v1.9.8.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "windShader"
{
	Properties
	{
		_WindTexture("Wind Texture", 2D) = "white" {}
		[Toggle]_TimeManualToggle("Time/Manual Toggle", Float) = 0
		_TimeScale("Time Scale", Float) = 1
		_ManualWindPanning("Manual Wind Panning", Range( -1 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.5
		#define ASE_VERSION 19801
		#pragma surface surf Unlit alpha:fade keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _WindTexture;
		uniform float _TimeManualToggle;
		uniform float _TimeScale;
		uniform float _ManualWindPanning;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float mulTime3 = _Time.y * _TimeScale;
			float4 appendResult7 = (float4(i.uv_texcoord.x , ( i.uv_texcoord.y + (( _TimeManualToggle )?( _ManualWindPanning ):( frac( mulTime3 ) )) ) , 0.0 , 0.0));
			float4 tex2DNode4 = tex2D( _WindTexture, appendResult7.xy, ddx( i.uv_texcoord ), ddy( i.uv_texcoord ) );
			float3 temp_output_4_5 = tex2DNode4.rgb;
			o.Emission = temp_output_4_5;
			o.Alpha = temp_output_4_5.x;
		}

		ENDCG
	}
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
}
/*ASEBEGIN
Version=19801
Node;AmplifyShaderEditor.RangedFloatNode;50;-2160,-128;Inherit;False;Property;_TimeScale;Time Scale;2;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;3;-2000,-128;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;51;-1824,-128;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-2000,112;Inherit;False;Property;_ManualWindPanning;Manual Wind Panning;3;0;Create;True;0;0;0;False;0;False;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;20;-1664,96;Inherit;False;Property;_TimeManualToggle;Time/Manual Toggle;1;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1;-1712,288;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;2;-1360,64;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DdyOpNode;6;-1024,304;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DdxOpNode;5;-1024,240;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;7;-1120,32;Inherit;True;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SamplerNode;4;-864,32;Inherit;True;Property;_WindTexture;Wind Texture;0;0;Create;True;0;0;0;False;0;False;-1;434abb688ac0dac47a27a918861cfd5a;434abb688ac0dac47a27a918861cfd5a;True;0;False;white;Auto;False;Object;-1;Derivative;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-256,-32;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;0;Unlit;windShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;0;False;;0;False;;False;0;False;;0;False;;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;False;2;5;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;0;50;0
WireConnection;51;0;3;0
WireConnection;20;0;51;0
WireConnection;20;1;21;0
WireConnection;2;0;1;2
WireConnection;2;1;20;0
WireConnection;6;0;1;0
WireConnection;5;0;1;0
WireConnection;7;0;1;1
WireConnection;7;1;2;0
WireConnection;4;1;7;0
WireConnection;4;3;5;0
WireConnection;4;4;6;0
WireConnection;0;2;4;5
WireConnection;0;9;4;5
ASEEND*/
//CHKSM=C488A0FF8DBDD7DEE088C7485D416971ACDA512F