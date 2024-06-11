package tech.csm.service;

import java.util.List;

import tech.csm.domain.State;

public interface StateService {

	List<State> getStateByCId(Integer cId);

}
