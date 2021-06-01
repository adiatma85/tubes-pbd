<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class About extends CI_Controller {
	
	public function __construct(){
	parent::__construct();
	}

	public function index()
	{
		$data['title']='Contoh Penerapan MySQL Stored Procedure di Codeigniter | About';
		$data['header']='<h1>About</h1>';
		$data['konten']='<p>Artikel ini dibuat dengan tujuan pembelajaran, silahkan untuk di-share atau dikembangkan dengan tidak menghilangkan halaman ini !</p>
		
		
		<p><b><span class="glyphicon glyphicon-user"></span>  Author </b> <br/>Issa Arwani, S.Kom.M.Sc</p>	

		<p><b><span class="glyphicon glyphicon-envelope"></span> Email </b><br/>issa.arwani[at]ub[dot]ac[dot]id</p>	
		
		';
		$this->load->view('v_dashboard',$data);
	}
	
	
	
}
