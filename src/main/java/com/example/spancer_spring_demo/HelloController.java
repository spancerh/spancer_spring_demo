package com.example.spancer_spring_demo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

	/*@GetMapping("/")*/
  @RequestMapping("/")
	public String index() {
		return "Greetings from Spring Boot! Spencer Hsieh";
	}

}
