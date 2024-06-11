package tech.csm.domain;

import java.io.Serializable;

import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity
@Getter
@Setter
@ToString
@Table(name = "State")
@NoArgsConstructor
@AllArgsConstructor
public class State implements Serializable {

	@Id
	@Column(name="sid")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int sid;
	
	@Column(name="name")
	private String name;
	
	@ManyToOne
	@JoinColumn(name = "cid")
	private Country country;
	
}
